import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:super_fitness_app/app/core/local/database_helper.dart';
import 'package:super_fitness_app/features/smart_coach/api/datasources/smart_coach_chat_local_data_source_impl.dart';

class MockDatabaseHelper extends Mock implements DatabaseHelper {}

void main() {
  late MockDatabaseHelper mockDbHelper;
  late SmartCoachChatLocalDataSourceImpl dataSource;

  setUp(() {
    mockDbHelper = MockDatabaseHelper();
    dataSource = SmartCoachChatLocalDataSourceImpl(mockDbHelper);
  });

  group('SmartCoachChatLocalDataSourceImpl', () {
    test('createChat should call database helper', () async {
      when(
        () => mockDbHelper.createChat(title: any(named: 'title')),
      ).thenAnswer((_) async => 1);

      final result = await dataSource.createChat('Test Chat');

      expect(result, 1);
      verify(() => mockDbHelper.createChat(title: 'Test Chat')).called(1);
    });

    test('getAllChats should call database helper', () async {
      final tChats = [
        {'id': 1, 'title': 'Chat 1'},
      ];
      when(() => mockDbHelper.getAllChats()).thenAnswer((_) async => tChats);

      final result = await dataSource.getAllChats();

      expect(result, tChats);
      verify(() => mockDbHelper.getAllChats()).called(1);
    });

    test('getMessagesByChat should call database helper', () async {
      final tMessages = [
        {'role': 'user', 'content': 'Hello'},
      ];
      when(
        () => mockDbHelper.getMessagesByChat(any()),
      ).thenAnswer((_) async => tMessages);

      final result = await dataSource.getMessagesByChat(1);

      expect(result, tMessages);
      verify(() => mockDbHelper.getMessagesByChat(1)).called(1);
    });

    test('insertMessage should call database helper', () async {
      when(
        () => mockDbHelper.insertMessage(any(), any(), any()),
      ).thenAnswer((_) async => 1);

      final result = await dataSource.insertMessage(
        chatId: 1,
        role: 'user',
        content: 'Hello',
      );

      expect(result, 1);
      verify(() => mockDbHelper.insertMessage(1, 'user', 'Hello')).called(1);
    });
  });
}
