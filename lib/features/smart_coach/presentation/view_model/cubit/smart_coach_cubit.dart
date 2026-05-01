import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/app/core/services/gemini_service.dart';
import 'package:super_fitness_app/features/smart_coach/domain/use_cases/create_chat_use_case.dart';
import 'package:super_fitness_app/features/smart_coach/domain/use_cases/get_all_chats_use_case.dart';
import 'package:super_fitness_app/features/smart_coach/domain/use_cases/get_messages_by_chat_use_case.dart';
import 'package:super_fitness_app/features/smart_coach/domain/use_cases/insert_message_use_case.dart';
import 'smart_coach_event.dart';
import 'smart_coach_state.dart';

@injectable
class SmartCoachCubit extends Cubit<SmartCoachState> {
  final CreateChatUseCase _createChatUseCase;
  final GetAllChatsUseCase _getAllChatsUseCase;
  final GetMessagesByChatUseCase _getMessagesByChatUseCase;
  final InsertMessageUseCase _insertMessageUseCase;
  final GeminiService _geminiService;

  SmartCoachCubit(
    this._createChatUseCase,
    this._getAllChatsUseCase,
    this._getMessagesByChatUseCase,
    this._insertMessageUseCase,
    this._geminiService,
  ) : super(SmartCoachState.initial());

  void doEvent(SmartCoachEvent event) {
    if (event is GetAllChats) {
      _getAllChats();
    } else if (event is GetMessagesByChat) {
      _getMessagesByChat(event.chatId);
    } else if (event is StartNewChat) {
      _startNewChat();
    } else if (event is SendMessage) {
      _sendMessage(event.content);
    }
  }

  Future<void> _getAllChats() async {
    emit(state.copyWith(chatsResource: Resource.loading()));
    try {
      final chats = await _getAllChatsUseCase.call();
      emit(state.copyWith(chatsResource: Resource.success(chats)));
    } catch (e) {
      emit(state.copyWith(chatsResource: Resource.error(e.toString())));
    }
  }

  Future<void> _getMessagesByChat(int chatId) async {
    emit(
      state.copyWith(
        messagesResource: Resource.loading(),
        currentChatId: chatId,
      ),
    );
    try {
      final messages = await _getMessagesByChatUseCase.call(chatId);
      emit(state.copyWith(messagesResource: Resource.success(messages)));
    } catch (e) {
      emit(state.copyWith(messagesResource: Resource.error(e.toString())));
    }
  }

  Future<void> _startNewChat() async {
    emit(
      state.copyWith(clearChatId: true, messagesResource: Resource.success([])),
    );
  }

  Future<void> _sendMessage(String content) async {
    final trimmedContent = content.trim();
    if (trimmedContent.isEmpty || state.isSendingMessage) return;

    int? chatId = state.currentChatId;
    if (chatId == null) {
      try {
        // Use first message as title (truncated)
        String title = trimmedContent.length > 30
            ? '${trimmedContent.substring(0, 30)}...'
            : trimmedContent;

        chatId = await _createChatUseCase.call(title: title);
        emit(state.copyWith(currentChatId: chatId));
        await _getAllChats();
      } catch (e) {
        return;
      }
    }

    try {
      await _insertMessageUseCase.call(
        chatId: chatId,
        role: 'user',
        content: trimmedContent,
      );

      final List<Map<String, dynamic>> currentMessages = List.from(
        state.messagesResource.data ?? [],
      );
      currentMessages.add({
        'role': 'user',
        'content': trimmedContent,
        'isError': false,
      });

      emit(
        state.copyWith(
          messagesResource: Resource.success(List.from(currentMessages)),
          isSendingMessage: true,
        ),
      );

      final history = currentMessages.sublist(0, currentMessages.length - 1);

      String fullResponse = "";
      bool isFirstChunk = true;

      print("DEBUG: Starting Gemini stream...");
      final stream = _geminiService.sendMessageStream(trimmedContent, history);

      await for (final chunk in stream) {
        if (chunk.startsWith('⚠️')) {
          throw chunk;
        }
        fullResponse += chunk;
        print("DEBUG: Received chunk: $chunk");

        if (isFirstChunk) {
          currentMessages.add({
            'role': 'bot',
            'content': fullResponse,
            'isError': fullResponse.startsWith('⚠️'),
          });
          isFirstChunk = false;
        } else {
          currentMessages[currentMessages.length - 1] = {
            'role': 'bot',
            'content': fullResponse,
            'isError': fullResponse.startsWith('⚠️'),
          };
        }

        emit(
          state.copyWith(
            messagesResource: Resource.success(List.from(currentMessages)),
          ),
        );
      }

      if (fullResponse.isNotEmpty) {
        await _insertMessageUseCase.call(
          chatId: chatId,
          role: 'bot',
          content: fullResponse,
        );
      }

      emit(state.copyWith(isSendingMessage: false));
      print("DEBUG: Stream finished and UI finalized.");
    } catch (e) {
      print("DEBUG: Error in _sendMessage: $e");
      String errorMessage = e.toString();
      if (errorMessage.contains('Quota exceeded') ||
          errorMessage.contains('429')) {
        final regExp = RegExp(r"retry in ([\d\.]+)s");
        final match = regExp.firstMatch(errorMessage);
        if (match != null) {
          final seconds = match.group(1);
          errorMessage = 'quota_reached_wait'.tr(args: [seconds ?? '']);
        } else {
          errorMessage = 'quota_reached'.tr();
        }
      } else if (!errorMessage.startsWith('⚠️')) {
        errorMessage = 'something_went_wrong_try_again'.tr();
      }

      final List<Map<String, dynamic>> currentMessages = List.from(
        state.messagesResource.data ?? [],
      );
      currentMessages.add({
        'role': 'bot',
        'content': errorMessage,
        'isError': true,
      });

      emit(
        state.copyWith(
          messagesResource: Resource.success(List.from(currentMessages)),
          isSendingMessage: false,
        ),
      );
    }
  }
}
