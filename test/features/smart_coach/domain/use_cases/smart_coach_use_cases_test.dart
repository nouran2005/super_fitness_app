import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:super_fitness_app/features/smart_coach/domain/repositories/smart_coach_chat_repository.dart';
import 'package:super_fitness_app/features/smart_coach/domain/use_cases/create_chat_use_case.dart';
import 'package:super_fitness_app/features/smart_coach/domain/use_cases/get_all_chats_use_case.dart';
import 'package:super_fitness_app/features/smart_coach/domain/use_cases/get_messages_by_chat_use_case.dart';
import 'package:super_fitness_app/features/smart_coach/domain/use_cases/insert_message_use_case.dart';

class MockSmartCoachChatRepository extends Mock
    implements SmartCoachChatRepository {}

void main() {
  late MockSmartCoachChatRepository mockRepository;

  setUp(() {
    mockRepository = MockSmartCoachChatRepository();
  });

  group('CreateChatUseCase', () {
    late CreateChatUseCase useCase;
    setUp(() => useCase = CreateChatUseCase(mockRepository));

    test('should call createChat on repository', () async {
      when(() => mockRepository.createChat(any())).thenAnswer((_) async => 1);
      final result = await useCase.call(title: 'Test');
      expect(result, 1);
      verify(() => mockRepository.createChat('Test')).called(1);
    });
  });

  group('GetAllChatsUseCase', () {
    late GetAllChatsUseCase useCase;
    setUp(() => useCase = GetAllChatsUseCase(mockRepository));

    test('should call getAllChats on repository', () async {
      final tChats = [
        {'id': 1, 'title': 'Chat 1'},
      ];
      when(() => mockRepository.getAllChats()).thenAnswer((_) async => tChats);
      final result = await useCase.call();
      expect(result, tChats);
      verify(() => mockRepository.getAllChats()).called(1);
    });
  });

  group('GetMessagesByChatUseCase', () {
    late GetMessagesByChatUseCase useCase;
    setUp(() => useCase = GetMessagesByChatUseCase(mockRepository));

    test('should call getMessagesByChat on repository', () async {
      final tMessages = [
        {'role': 'user', 'content': 'Hello'},
      ];
      when(
        () => mockRepository.getMessagesByChat(any()),
      ).thenAnswer((_) async => tMessages);
      final result = await useCase.call(1);
      expect(result, tMessages);
      verify(() => mockRepository.getMessagesByChat(1)).called(1);
    });
  });

  group('InsertMessageUseCase', () {
    late InsertMessageUseCase useCase;
    setUp(() => useCase = InsertMessageUseCase(mockRepository));

    test('should call insertMessage on repository', () async {
      when(
        () => mockRepository.insertMessage(
          chatId: any(named: 'chatId'),
          role: any(named: 'role'),
          content: any(named: 'content'),
        ),
      ).thenAnswer((_) async => 1);

      final result = await useCase.call(
        chatId: 1,
        role: 'user',
        content: 'Hello',
      );
      expect(result, 1);
      verify(
        () => mockRepository.insertMessage(
          chatId: 1,
          role: 'user',
          content: 'Hello',
        ),
      ).called(1);
    });
  });
}
