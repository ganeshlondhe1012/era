import '../models/chat.dart';

abstract class ChatRepository {
  Future<List<Chat>> loadChats();

  Future<void> saveChats(List<Chat> chats);

  Future<void> deleteAllChats();
}
