import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:super_fitness_app/features/smart_coach/data/datasources/smart_coach_chat_local_data_source_contract.dart';
import 'package:super_fitness_app/features/smart_coach/data/repositories/smart_coach_chat_repository_impl.dart';

class MockSmartCoachChatLocalDataSource extends Mock
    implements SmartCoachChatLocalDataSource {}

void main() {
  late MockSmartCoachChatLocalDataSource mockDataSource;
  late SmartCoachChatRepositoryImpl repository;

  setUp(() {
    mockDataSource = MockSmartCoachChatLocalDataSource();
    repository = SmartCoachChatRepositoryImpl(mockDataSource);
  });

  group('SmartCoachChatRepositoryImpl', () {
    test('createChat should call data source', () async {
      when(() => mockDataSource.createChat(any())).thenAnswer((_) async => 1);
      final result = await repository.createChat('Test');
      expect(result, 1);
      verify(() => mockDataSource.createChat('Test')).called(1);
    });

    test('getAllChats should call data source', () async {
      final tChats = [
        {'id': 1, 'title': 'Chat 1'},
      ];
      when(() => mockDataSource.getAllChats()).thenAnswer((_) async => tChats);
      final result = await repository.getAllChats();
      expect(result, tChats);
      verify(() => mockDataSource.getAllChats()).called(1);
    });

    test('getMessagesByChat should call data source', () async {
      final tMessages = [
        {'role': 'user', 'content': 'Hello'},
      ];
      when(
        () => mockDataSource.getMessagesByChat(any()),
      ).thenAnswer((_) async => tMessages);
      final result = await repository.getMessagesByChat(1);
      expect(result, tMessages);
      verify(() => mockDataSource.getMessagesByChat(1)).called(1);
    });

    test('insertMessage should call data source', () async {
      when(
        () => mockDataSource.insertMessage(
          chatId: any(named: 'chatId'),
          role: any(named: 'role'),
          content: any(named: 'content'),
        ),
      ).thenAnswer((_) async => 1);

      final result = await repository.insertMessage(
        chatId: 1,
        role: 'user',
        content: 'Hello',
      );
      expect(result, 1);
      verify(
        () => mockDataSource.insertMessage(
          chatId: 1,
          role: 'user',
          content: 'Hello',
        ),
      ).called(1);
    });
  });
}
