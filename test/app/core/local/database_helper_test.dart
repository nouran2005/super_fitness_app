import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart';

/// Creates a fresh in-memory database with the same schema as DatabaseHelper.
Future<Database> _createTestDb() async {
  return await databaseFactory.openDatabase(
    inMemoryDatabasePath,
    options: OpenDatabaseOptions(
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE chats (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
          )
        ''');
        await db.execute('''
          CREATE TABLE messages (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            chatId INTEGER,
            role TEXT,
            content TEXT,
            createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            FOREIGN KEY (chatId) REFERENCES chats (id) ON DELETE CASCADE
          )
        ''');
      },
    ),
  );
}

void main() {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  group('DatabaseHelper schema & operations', () {
    late Database db;

    setUp(() async {
      db = await _createTestDb();
    });

    tearDown(() async {
      await db.close();
    });

    test('database opens successfully', () {
      expect(db.isOpen, isTrue);
    });

    test('createChat inserts a chat and returns valid ID', () async {
      final id = await db.insert('chats', {'title': 'My Chat'});
      expect(id, greaterThan(0));
    });

    test('getAllChats returns all inserted chats', () async {
      await db.insert('chats', {'title': 'Chat 1'});
      await db.insert('chats', {'title': 'Chat 2'});

      final chats = await db.query('chats', orderBy: 'createdAt DESC');

      expect(chats.length, 2);
      expect(chats.map((c) => c['title']), containsAll(['Chat 1', 'Chat 2']));
    });

    test('getAllChats returns empty list when no chats exist', () async {
      final chats = await db.query('chats');
      expect(chats, isEmpty);
    });

    test('insertMessage adds a message linked to a chat', () async {
      final chatId = await db.insert('chats', {'title': 'Test Chat'});
      final msgId = await db.insert('messages', {
        'chatId': chatId,
        'role': 'user',
        'content': 'Hello!',
      });
      expect(msgId, greaterThan(0));
    });

    test('getMessagesByChat returns messages for the correct chat', () async {
      final chatId = await db.insert('chats', {'title': 'Test Chat'});
      await db.insert('messages', {
        'chatId': chatId,
        'role': 'user',
        'content': 'Hello!',
      });
      await db.insert('messages', {
        'chatId': chatId,
        'role': 'assistant',
        'content': 'Hi!',
      });

      final messages = await db.query(
        'messages',
        where: 'chatId = ?',
        whereArgs: [chatId],
        orderBy: 'createdAt ASC',
      );

      expect(messages.length, 2);
      expect(messages[0]['role'], 'user');
      expect(messages[0]['content'], 'Hello!');
      expect(messages[1]['role'], 'assistant');
    });

    test(
      'getMessagesByChat returns empty list for non-existent chatId',
      () async {
        final messages = await db.query(
          'messages',
          where: 'chatId = ?',
          whereArgs: [999],
        );
        expect(messages, isEmpty);
      },
    );

    test('messages from different chats are correctly isolated', () async {
      final chat1 = await db.insert('chats', {'title': 'Chat 1'});
      final chat2 = await db.insert('chats', {'title': 'Chat 2'});

      await db.insert('messages', {
        'chatId': chat1,
        'role': 'user',
        'content': 'Chat 1 msg',
      });
      await db.insert('messages', {
        'chatId': chat2,
        'role': 'user',
        'content': 'Chat 2 msg',
      });

      final chat1Msgs = await db.query(
        'messages',
        where: 'chatId = ?',
        whereArgs: [chat1],
      );
      final chat2Msgs = await db.query(
        'messages',
        where: 'chatId = ?',
        whereArgs: [chat2],
      );

      expect(chat1Msgs.length, 1);
      expect(chat1Msgs[0]['content'], 'Chat 1 msg');
      expect(chat2Msgs.length, 1);
      expect(chat2Msgs[0]['content'], 'Chat 2 msg');
    });
  });
}
