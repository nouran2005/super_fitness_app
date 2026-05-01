import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/app/core/services/gemini_service.dart';
import 'package:super_fitness_app/features/smart_coach/domain/use_cases/create_chat_use_case.dart';
import 'package:super_fitness_app/features/smart_coach/domain/use_cases/get_all_chats_use_case.dart';
import 'package:super_fitness_app/features/smart_coach/domain/use_cases/get_messages_by_chat_use_case.dart';
import 'package:super_fitness_app/features/smart_coach/domain/use_cases/insert_message_use_case.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/cubit/smart_coach_cubit.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/cubit/smart_coach_event.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/cubit/smart_coach_state.dart';

class MockCreateChatUseCase extends Mock implements CreateChatUseCase {}

class MockGetAllChatsUseCase extends Mock implements GetAllChatsUseCase {}

class MockGetMessagesByChatUseCase extends Mock
    implements GetMessagesByChatUseCase {}

class MockInsertMessageUseCase extends Mock implements InsertMessageUseCase {}

class MockGeminiService extends Mock implements GeminiService {}

void main() {
  late SmartCoachCubit cubit;
  late MockCreateChatUseCase mockCreateChatUseCase;
  late MockGetAllChatsUseCase mockGetAllChatsUseCase;
  late MockGetMessagesByChatUseCase mockGetMessagesByChatUseCase;
  late MockInsertMessageUseCase mockInsertMessageUseCase;
  late MockGeminiService mockGeminiService;

  setUp(() {
    mockCreateChatUseCase = MockCreateChatUseCase();
    mockGetAllChatsUseCase = MockGetAllChatsUseCase();
    mockGetMessagesByChatUseCase = MockGetMessagesByChatUseCase();
    mockInsertMessageUseCase = MockInsertMessageUseCase();
    mockGeminiService = MockGeminiService();

    cubit = SmartCoachCubit(
      mockCreateChatUseCase,
      mockGetAllChatsUseCase,
      mockGetMessagesByChatUseCase,
      mockInsertMessageUseCase,
      mockGeminiService,
    );
  });

  tearDown(() {
    cubit.close();
  });

  final tChats = [
    {'id': 1, 'title': 'Chat 1'},
    {'id': 2, 'title': 'Chat 2'},
  ];

  final tMessages = [
    {'role': 'user', 'content': 'Hello', 'isError': false},
    {'role': 'bot', 'content': 'Hi there!', 'isError': false},
  ];

  group('SmartCoachCubit', () {
    test('initial state is correct', () {
      expect(cubit.state, SmartCoachState.initial());
    });

    group('GetAllChats', () {
      blocTest<SmartCoachCubit, SmartCoachState>(
        'emits [loading, success] when GetAllChats is successful',
        build: () {
          when(
            () => mockGetAllChatsUseCase.call(),
          ).thenAnswer((_) async => tChats);
          return cubit;
        },
        act: (cubit) => cubit.doEvent(GetAllChats()),
        expect: () => [
          cubit.state.copyWith(chatsResource: Resource.loading()),
          cubit.state.copyWith(chatsResource: Resource.success(tChats)),
        ],
      );

      blocTest<SmartCoachCubit, SmartCoachState>(
        'emits [loading, error] when GetAllChats fails',
        build: () {
          when(
            () => mockGetAllChatsUseCase.call(),
          ).thenThrow(Exception('Error'));
          return cubit;
        },
        act: (cubit) => cubit.doEvent(GetAllChats()),
        expect: () => [
          cubit.state.copyWith(chatsResource: Resource.loading()),
          cubit.state.copyWith(
            chatsResource: Resource.error('Exception: Error'),
          ),
        ],
      );
    });

    group('GetMessagesByChat', () {
      blocTest<SmartCoachCubit, SmartCoachState>(
        'emits [loading, success] when GetMessagesByChat is successful',
        build: () {
          when(
            () => mockGetMessagesByChatUseCase.call(any()),
          ).thenAnswer((_) async => tMessages);
          return cubit;
        },
        act: (cubit) => cubit.doEvent(GetMessagesByChat(1)),
        expect: () => [
          cubit.state.copyWith(
            messagesResource: Resource.loading(),
            currentChatId: 1,
          ),
          cubit.state.copyWith(
            messagesResource: Resource.success(tMessages),
            currentChatId: 1,
          ),
        ],
      );

      blocTest<SmartCoachCubit, SmartCoachState>(
        'emits [loading, error] when GetMessagesByChat fails',
        build: () {
          when(
            () => mockGetMessagesByChatUseCase.call(any()),
          ).thenThrow(Exception('Error'));
          return cubit;
        },
        act: (cubit) => cubit.doEvent(GetMessagesByChat(1)),
        expect: () => [
          cubit.state.copyWith(
            messagesResource: Resource.loading(),
            currentChatId: 1,
          ),
          cubit.state.copyWith(
            messagesResource: Resource.error('Exception: Error'),
            currentChatId: 1,
          ),
        ],
      );
    });

    group('StartNewChat', () {
      blocTest<SmartCoachCubit, SmartCoachState>(
        'emits correct states when StartNewChat is successful',
        build: () {
          when(
            () => mockCreateChatUseCase.call(title: any(named: 'title')),
          ).thenAnswer((_) async => 1);
          when(
            () => mockGetAllChatsUseCase.call(),
          ).thenAnswer((_) async => tChats);
          when(
            () => mockGetMessagesByChatUseCase.call(any()),
          ).thenAnswer((_) async => []);
          return cubit;
        },
        act: (cubit) => cubit.doEvent(StartNewChat()),
        expect: () => [
          // 1. currentChatId updated
          isA<SmartCoachState>().having(
            (s) => s.currentChatId,
            'currentChatId',
            1,
          ),
          // 2. _getAllChats loading
          isA<SmartCoachState>().having(
            (s) => s.chatsResource.status,
            'chatsResource status',
            Status.loading,
          ),
          // 3. _getMessagesByChat loading
          isA<SmartCoachState>().having(
            (s) => s.messagesResource.status,
            'messagesResource status',
            Status.loading,
          ),
          // 4. _getAllChats success
          isA<SmartCoachState>().having(
            (s) => s.chatsResource.status,
            'chatsResource status',
            Status.success,
          ),
          // 5. _getMessagesByChat success
          isA<SmartCoachState>().having(
            (s) => s.messagesResource.status,
            'messagesResource status',
            Status.success,
          ),
        ],
      );
    });

    group('SendMessage', () {
      final tContent = 'Hello';
      final tChatId = 1;

      blocTest<SmartCoachCubit, SmartCoachState>(
        'emits streaming updates when SendMessage is successful',
        build: () {
          when(
            () => mockInsertMessageUseCase.call(
              chatId: any(named: 'chatId'),
              role: any(named: 'role'),
              content: any(named: 'content'),
            ),
          ).thenAnswer((_) async => 1);

          when(
            () => mockGeminiService.sendMessageStream(any(), any()),
          ).thenAnswer((_) => Stream.fromIterable(['He', 'llo', ' world']));

          return cubit;
        },
        seed: () => SmartCoachState.initial().copyWith(
          currentChatId: tChatId,
          messagesResource: Resource.success([]),
        ),
        act: (cubit) => cubit.doEvent(SendMessage(tContent)),
        expect: () => [
          // User message added & isSendingMessage: true
          isA<SmartCoachState>()
              .having((s) => s.isSendingMessage, 'isSendingMessage', true)
              .having(
                (s) => (s.messagesResource.data as List).length,
                'messages length',
                1,
              ),
          // Streaming started - chunk 1 "He"
          isA<SmartCoachState>().having(
            (s) => (s.messagesResource.data as List).last['content'],
            'content',
            'He',
          ),
          // Streaming chunk 2 "Hello"
          isA<SmartCoachState>().having(
            (s) => (s.messagesResource.data as List).last['content'],
            'content',
            'Hello',
          ),
          // Streaming chunk 3 "Hello world"
          isA<SmartCoachState>().having(
            (s) => (s.messagesResource.data as List).last['content'],
            'content',
            'Hello world',
          ),
          // Final state: isSendingMessage: false
          isA<SmartCoachState>().having(
            (s) => s.isSendingMessage,
            'isSendingMessage',
            false,
          ),
        ],
      );

      blocTest<SmartCoachCubit, SmartCoachState>(
        'creates a new chat if currentChatId is null when SendMessage is called',
        build: () {
          when(
            () => mockCreateChatUseCase.call(title: any(named: 'title')),
          ).thenAnswer((_) async => tChatId);
          when(
            () => mockGetAllChatsUseCase.call(),
          ).thenAnswer((_) async => tChats);
          when(
            () => mockInsertMessageUseCase.call(
              chatId: any(named: 'chatId'),
              role: any(named: 'role'),
              content: any(named: 'content'),
            ),
          ).thenAnswer((_) async => 1);
          when(
            () => mockGeminiService.sendMessageStream(any(), any()),
          ).thenAnswer((_) => Stream.fromIterable(['Bot response']));

          return cubit;
        },
        act: (cubit) => cubit.doEvent(SendMessage(tContent)),
        expect: () => [
          // 1. New chat ID set
          isA<SmartCoachState>().having(
            (s) => s.currentChatId,
            'currentChatId',
            tChatId,
          ),
          // 2. _getAllChats loading
          isA<SmartCoachState>().having(
            (s) => s.chatsResource.status,
            'chatsResource status',
            Status.loading,
          ),
          // 3. _getAllChats success
          isA<SmartCoachState>().having(
            (s) => s.chatsResource.status,
            'chatsResource status',
            Status.success,
          ),
          // 4. User message added & isSendingMessage: true
          isA<SmartCoachState>().having(
            (s) => s.isSendingMessage,
            'isSendingMessage',
            true,
          ),
          // 5. Bot response chunk
          isA<SmartCoachState>().having(
            (s) => (s.messagesResource.data as List).last['content'],
            'content',
            'Bot response',
          ),
          // 6. Finished
          isA<SmartCoachState>().having(
            (s) => s.isSendingMessage,
            'isSendingMessage',
            false,
          ),
        ],
      );

      blocTest<SmartCoachCubit, SmartCoachState>(
        'emits error message when Gemini service throws quota exceeded error',
        build: () {
          when(
            () => mockInsertMessageUseCase.call(
              chatId: any(named: 'chatId'),
              role: any(named: 'role'),
              content: any(named: 'content'),
            ),
          ).thenAnswer((_) async => 1);

          when(
            () => mockGeminiService.sendMessageStream(any(), any()),
          ).thenAnswer((_) => Stream.error('Quota exceeded'));

          return cubit;
        },
        seed: () => SmartCoachState.initial().copyWith(
          currentChatId: tChatId,
          messagesResource: Resource.success([]),
        ),
        act: (cubit) => cubit.doEvent(SendMessage(tContent)),
        expect: () => [
          // User message added
          isA<SmartCoachState>().having(
            (s) => s.isSendingMessage,
            'isSendingMessage',
            true,
          ),
          // Error message added and isSendingMessage: false
          isA<SmartCoachState>()
              .having((s) => s.isSendingMessage, 'isSendingMessage', false)
              .having(
                (s) => (s.messagesResource.data as List).last['content'],
                'content',
                contains('Quota reached'),
              ),
        ],
      );
    });
  });
}
