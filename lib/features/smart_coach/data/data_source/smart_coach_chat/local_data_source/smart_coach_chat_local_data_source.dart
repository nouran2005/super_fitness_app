import 'package:super_fitness_app/app/core/local/database_helper.dart';
import 'package:injectable/injectable.dart';

abstract interface class SmartCoachChatLocalDataSource {
  Future<int> createChat(String? title);

  Future<List<Map<String, dynamic>>> getAllChats();

  Future<int> insertMessage({
    required int chatId,
    required String role,
    required String content,
  });

  Future<List<Map<String, dynamic>>> getMessagesByChat(int chatId);
}

@Injectable(as: SmartCoachChatLocalDataSource)
class SmartCoachChatLocalDataSourceImpl
    implements SmartCoachChatLocalDataSource {
  final DatabaseHelper _dbHelper;

  const SmartCoachChatLocalDataSourceImpl(this._dbHelper);

  @override
  Future<int> createChat(String? title) async {
    return await _dbHelper.createChat(title: title);
  }

  @override
  Future<List<Map<String, dynamic>>> getAllChats() async {
    return await _dbHelper.getAllChats();
  }

  @override
  Future<List<Map<String, dynamic>>> getMessagesByChat(int chatId) async {
    return await _dbHelper.getMessagesByChat(chatId);
  }

  @override
  Future<int> insertMessage({
    required int chatId,
    required String role,
    required String content,
  }) async {
    return await _dbHelper.insertMessage(chatId, role, content);
  }
}
