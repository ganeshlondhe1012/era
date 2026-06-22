import 'package:flutter/material.dart';

import '../models/message.dart';

class ChatController extends ChangeNotifier {
  ChatController();

  final List<Message> _messages = [];

  List<Message> get messages => List.unmodifiable(_messages);

  bool get hasMessages => _messages.isNotEmpty;

  void sendUserMessage(String text) {
    final message = Message(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      text: text.trim(),
      isUser: true,
      createdAt: DateTime.now(),
    );

    _messages.add(message);

    notifyListeners();
  }

  void addAssistantMessage(String text) {
    final message = Message(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      text: text.trim(),
      isUser: false,
      createdAt: DateTime.now(),
    );

    _messages.add(message);

    notifyListeners();
  }

  void clearChat() {
    _messages.clear();

    notifyListeners();
  }
}