import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GeminiService {
  late final GenerativeModel _model;

  GeminiService() {
    final geminiKey = dotenv.get('gemini_key', fallback: "");

    // Initialize the model once (Lazy Singleton)
    _model = GenerativeModel(
      model:
          'gemini-2.0-flash', // Using flash model for high performance and low latency
      apiKey: geminiKey,
      systemInstruction: Content.system(
        "You are a professional fitness coach. Help users with workouts, nutrition, and calorie calculation in a simple, clear, and friendly way. Ensure responses are concise and practical.",
      ),
    );
  }

  /// Sends a message and returns a stream of chunks for a real-time typing effect.
  Stream<String> sendMessageStream(
    String userMessage,
    List<Map<String, dynamic>> history,
  ) async* {
    // 1. Limit history to last 15 messages for performance (context management)
    final limitedHistory = history.length > 15
        ? history.sublist(history.length - 15)
        : history;

    // 2. Convert history to Gemini format (Fix: Ensure no duplication)
    // The 'history' passed here should NOT contain the current 'userMessage'.
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
        return; // Success, exit retry loop
      } on GenerativeAIException catch (e) {
        // Handle 503 Service Unavailable or Overloaded
        if (i == retries - 1) {
          yield "⚠️ The server is busy right now. Please try again later.";
          return;
        }
      } on SocketException catch (_) {
        // Handle Network/Connection issues
        if (i == retries - 1) {
          yield "⚠️ Network error. Please check your connection.";
          return;
        }
      } catch (e) {
        // Handle unexpected errors
        if (i == retries - 1) {
          yield "⚠️ Something went wrong. Please try again in a moment.";
          return;
        }
      }

      // Exponential backoff: 1s, 2s, 4s...
      await Future.delayed(Duration(seconds: delaySeconds));
      delaySeconds *= 2;
    }
  }
}
