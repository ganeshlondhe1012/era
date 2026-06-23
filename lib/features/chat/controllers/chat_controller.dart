import 'package:flutter/material.dart';

import '../../../core/ai/providers/ai_provider.dart';

import '../models/chat.dart';
import '../models/message.dart';
import '../services/chat_service.dart';

class ChatController extends ChangeNotifier {
 ChatController({
  required AIProvider provider,
}) : _chatService = ChatService(provider: provider) {
  initialize();
}

  final ChatService _chatService;

  final List<Chat> _chats = [
    Chat(
      id: '1',
      title: 'New Chat',
      createdAt: DateTime.now(),
      messages: const [],
    ),
  ];
  
  List<String> _availableModels = [];

String? _selectedModel;

List<String> get availableModels =>
    List.unmodifiable(_availableModels);

String? get selectedModel => _selectedModel;

bool get hasModels => _availableModels.isNotEmpty;

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

Future<void> initialize() async {
  _availableModels = [];
  _selectedModel = null;

  final connected = await _chatService.isReady();

  if (!connected) {
    notifyListeners();
    return;
  }

  await refreshModels();
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


Future<void> refreshModels() async {
  try {
    final models = await _chatService.getInstalledModels();

    _availableModels = models;

    if (_availableModels.isNotEmpty) {
      _selectedModel ??= _availableModels.first;
    }
  } catch (_) {
    _availableModels = [];
    _selectedModel = null;
  }

  notifyListeners();
}

void selectModel(String model) {
  if (_selectedModel == model) return;

  _selectedModel = model;

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
  if (_selectedModel == null) {
    throw Exception(
      'No Ollama model selected.',
    );
  }

  final assistantMessage = Message(
    id: DateTime.now().microsecondsSinceEpoch.toString(),
    text: '',
    isUser: false,
    createdAt: DateTime.now(),
  );

  _appendMessage(assistantMessage);

  var buffer = '';

  await for (final chunk in _chatService.streamPrompt(
    prompt: prompt,
    model: _selectedModel!,
  )) {
    if (chunk.isDone) {
      break;
    }

    buffer += chunk.text;

    _updateLastMessage(buffer);
    }
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

  void _updateLastMessage(String text) {
  if (currentChat.messages.isEmpty) {
    return;
  }

  final updatedMessages = List<Message>.from(currentChat.messages);

  final last = updatedMessages.last;

  updatedMessages[updatedMessages.length - 1] = last.copyWith(
    text: text,
  );

  _replaceCurrentChat(
    currentChat.copyWith(
      messages: updatedMessages,
    ),
  );

  notifyListeners();
}

  void _replaceCurrentChat(Chat chat) {
    _chats[_currentChatIndex] = chat;
  }
}