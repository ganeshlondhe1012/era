import 'package:flutter/material.dart';

import '../../../core/ai/providers/ai_provider.dart';
import '../models/ai_response.dart';
import '../models/chat.dart';
import '../models/message.dart';
import '../services/chat_service.dart';

class ChatController extends ChangeNotifier {
  ChatController({
    required AIProvider provider,
  }) : _chatService = ChatService(provider: provider);

  final ChatService _chatService;

  final List<Chat> _chats = [
    Chat(
      id: '1',
      title: 'New Chat',
      createdAt: DateTime.now(),
      messages: const [],
    ),
  ];

  int _currentChatIndex = 0;

  bool _isGenerating = false;

  List<Chat> get chats => List.unmodifiable(_chats);

  int get currentChatIndex => _currentChatIndex;

  Chat get currentChat => _chats[_currentChatIndex];

  List<Message> get messages => currentChat.messages;

  bool get hasMessages => messages.isNotEmpty;

  bool get isGenerating => _isGenerating;

  Future<bool> isAiAvailable() {
    return _chatService.isReady();
  }

  void switchChat(int index) {
    if (index == _currentChatIndex) return;
    if (index < 0 || index >= _chats.length) return;

    _currentChatIndex = index;
    notifyListeners();
  }

  void createNewChat() {
    _chats.add(
      Chat(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: 'New Chat',
        createdAt: DateTime.now(),
        messages: const [],
      ),
    );

    _currentChatIndex = _chats.length - 1;

    notifyListeners();
  }

  Future<void> sendMessage(String text) async {
    if (_isGenerating) return;

    final prompt = text.trim();

    if (prompt.isEmpty) return;

    _appendMessage(
      Message(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        text: prompt,
        isUser: true,
        createdAt: DateTime.now(),
      ),
    );

    _isGenerating = true;
    notifyListeners();

    try {
      final AIResponse response =
          await _chatService.sendPrompt(prompt);

      _appendMessage(
        Message(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
         text: response.text,
          isUser: false,
          createdAt: DateTime.now(),
        ),
      );
    } catch (e) {
      _appendMessage(
        Message(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          text: 'Error: $e',
          isUser: false,
          createdAt: DateTime.now(),
        ),
      );
    } finally {
      _isGenerating = false;
      notifyListeners();
    }
  }

  void clearCurrentChat() {
    _replaceCurrentChat(
      currentChat.copyWith(
        messages: const [],
      ),
    );

    notifyListeners();
  }

  void _appendMessage(Message message) {
    final updatedMessages = List<Message>.from(currentChat.messages)
      ..add(message);

    _replaceCurrentChat(
      currentChat.copyWith(
        messages: updatedMessages,
      ),
    );
  }

  void _replaceCurrentChat(Chat chat) {
    _chats[_currentChatIndex] = chat;
  }
}