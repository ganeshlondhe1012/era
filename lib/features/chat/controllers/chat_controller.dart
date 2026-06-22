import 'package:flutter/material.dart';

import '../models/chat.dart';
import '../models/message.dart';

class ChatController extends ChangeNotifier {
  ChatController() {
    _createInitialChat();
  }

  final List<Chat> _chats = [];

  int _currentChatIndex = 0;

  List<Chat> get chats => List.unmodifiable(_chats);

  int get currentChatIndex => _currentChatIndex;

  Chat get currentChat => _chats[_currentChatIndex];

  List<Message> get messages => currentChat.messages;

  bool get hasMessages => currentChat.messages.isNotEmpty;

  void _createInitialChat() {
    _chats.add(
      Chat(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: "New Chat",
        createdAt: DateTime.now(),
        messages: const [],
      ),
    );
  }

  void createNewChat() {
    _chats.add(
      Chat(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: "New Chat",
        createdAt: DateTime.now(),
        messages: const [],
      ),
    );

    _currentChatIndex = _chats.length - 1;

    notifyListeners();
  }

  void switchChat(int index) {
    if (index < 0 || index >= _chats.length) {
      return;
    }

    _currentChatIndex = index;

    notifyListeners();
  }

  void sendUserMessage(String text) {
    final message = Message(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      text: text.trim(),
      isUser: true,
      createdAt: DateTime.now(),
    );

    final updatedMessages = List<Message>.from(currentChat.messages)
      ..add(message);

    _chats[_currentChatIndex] = currentChat.copyWith(
      messages: updatedMessages,
    );

    notifyListeners();
  }

  void addAssistantMessage(String text) {
    final message = Message(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      text: text.trim(),
      isUser: false,
      createdAt: DateTime.now(),
    );

    final updatedMessages = List<Message>.from(currentChat.messages)
      ..add(message);

    _chats[_currentChatIndex] = currentChat.copyWith(
      messages: updatedMessages,
    );

    notifyListeners();
  }

  void clearCurrentChat() {
    _chats[_currentChatIndex] = currentChat.copyWith(
      messages: const [],
    );

    notifyListeners();
  }
}