import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GeminiService {
  late final GenerativeModel _model;

  GeminiService() {
    final geminiKey = dotenv.get('gemini_key', fallback: "");

    _model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: geminiKey,
      systemInstruction: Content.system(
        "You are a professional fitness coach. Help users with workouts, nutrition, and calorie calculation in a simple, clear, and friendly way. Ensure responses are concise and practical.",
      ),
    );
  }

  Stream<String> sendMessageStream(
    String userMessage,
    List<Map<String, dynamic>> history,
  ) async* {
    final limitedHistory = history.length > 15
        ? history.sublist(history.length - 15)
        : history;

    final chatHistory = limitedHistory.map((msg) {
      final role = msg['role'] == 'user' ? 'user' : 'model';
      return Content(role, [TextPart(msg['content'] as String)]);
    }).toList();

    int retries = 3;
    int delaySeconds = 1;

    for (int i = 0; i < retries; i++) {
      try {
        final chat = _model.startChat(history: chatHistory);
        final stream = chat.sendMessageStream(Content.text(userMessage));

        bool hasContent = false;
        await for (final response in stream) {
          if (response.text != null && response.text!.isNotEmpty) {
            hasContent = true;
            yield response.text!;
          }
        }

        if (!hasContent) throw Exception("Empty response");
        return;
      } on GenerativeAIException catch (e) {
        if (i == retries - 1) {
          yield "⚠️ The server is busy right now. Please try again later.";
          return;
        }
      } on SocketException catch (_) {
        if (i == retries - 1) {
          yield "⚠️ Network error. Please check your connection.";
          return;
        }
      } catch (e) {
        if (i == retries - 1) {
          yield "⚠️ Something went wrong. Please try again in a moment.";
          return;
        }
      }
      await Future.delayed(Duration(seconds: delaySeconds));
      delaySeconds *= 2;
    }
  }
}
