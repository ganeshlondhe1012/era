import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/chat.dart';
import 'chat_repository.dart';

/// Temporary repository implementation.
///
/// Uses SharedPreferences for V1.
/// The interface remains identical so we can migrate to
/// SQLite later without changing ChatController.
class SqliteChatRepository implements ChatRepository {
  static const _storageKey = 'era_chats';

  @override
  Future<List<Chat>> loadChats() async {
    final prefs = await SharedPreferences.getInstance();

    final jsonString = prefs.getString(_storageKey);

    if (jsonString == null || jsonString.isEmpty) {
      return [];
    }

    final List<dynamic> decoded =
        jsonDecode(jsonString) as List<dynamic>;

    return decoded
        .cast<Map<String, dynamic>>()
        .map(Chat.fromMap)
        .toList();
  }

  @override
  Future<void> saveChats(
    List<Chat> chats,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    final json = chats
        .map((chat) => chat.toMap())
        .toList();

    await prefs.setString(
      _storageKey,
      jsonEncode(json),
    );
  }

  @override
  Future<void> deleteAllChats() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_storageKey);
  }
}