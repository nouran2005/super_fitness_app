import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'smart_coach.db');

    return await openDatabase(
      path,
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
    );
  }

  Future<int> createChat({String? title}) async {
    final db = await database;
    return await db.insert('chats', {'title': title});
  }

  Future<List<Map<String, dynamic>>> getAllChats() async {
    final db = await database;
    return await db.query('chats', orderBy: 'createdAt DESC');
  }

  Future<int> insertMessage(int chatId, String role, String content) async {
    final db = await database;
    return await db.insert('messages', {
      'chatId': chatId,
      'role': role,
      'content': content,
    });
  }

  Future<List<Map<String, dynamic>>> getMessagesByChat(int chatId) async {
    final db = await database;
    return await db.query(
      'messages',
      where: 'chatId = ?',
      whereArgs: [chatId],
      orderBy: 'createdAt ASC',
    );
  }
}
