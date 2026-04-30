import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/features/smart_coach/data/datasources/smart_coach_chat_local_data_source_contract.dart';
import 'package:super_fitness_app/features/smart_coach/domain/repositories/smart_coach_chat_repository.dart';

@Injectable(as: SmartCoachChatRepository)
class SmartCoachChatRepositoryImpl implements SmartCoachChatRepository {
  final SmartCoachChatLocalDataSource _smartCoachChatLocalDataSource;

  const SmartCoachChatRepositoryImpl(this._smartCoachChatLocalDataSource);

  @override
  Future<int> createChat(String? title) async {
    return await _smartCoachChatLocalDataSource.createChat(title);
  }

  @override
  Future<List<Map<String, dynamic>>> getAllChats() async {
    return await _smartCoachChatLocalDataSource.getAllChats();
  }

  @override
  Future<List<Map<String, dynamic>>> getMessagesByChat(int chatId) async {
    return await _smartCoachChatLocalDataSource.getMessagesByChat(chatId);
  }

  @override
  Future<int> insertMessage({
    required int chatId,
    required String role,
    required String content,
  }) async {
    return await _smartCoachChatLocalDataSource.insertMessage(
      chatId: chatId,
      role: role,
      content: content,
    );
  }
}
