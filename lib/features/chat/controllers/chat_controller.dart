import 'package:flutter/material.dart';

import '../../../core/ai/providers/ai_provider.dart';

import '../models/chat.dart';
import '../models/message.dart';
import '../services/chat_service.dart';

import '../repository/chat_repository.dart';
import '../repository/sqlite_chat_repository.dart';
import '../models/generation_state.dart';
import '../services/generation_controller.dart';

import '../../memory/services/memory_extractor.dart';
import '../../memory/services/memory_service.dart';
import '../../memory/repository/local_repository.dart';

import '../services/chat_pipeline.dart';
import '../services/prompt_builder.dart';

class ChatController extends ChangeNotifier {
ChatController({
  required AIProvider provider,
}) : _chatService = ChatService(
        provider: provider,
      ) {
  _memoryService = MemoryService(
    repository: LocalMemoryRepository(),
  );

  _chatPipeline = ChatPipeline(
    chatService: _chatService,
    memoryExtractor: const MemoryExtractor(),
    memoryService: _memoryService,
    promptBuilder: const PromptBuilder(),
  );

  initialize();
}

  final ChatService _chatService;
  late final MemoryService _memoryService;

late final ChatPipeline _chatPipeline;

  final GenerationController _generationController =
    GenerationController();

  final ChatRepository _repository = SqliteChatRepository();

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

 GenerationState _generationState =
    GenerationState.idle;

  List<Chat> get chats => List.unmodifiable(_chats);

  GenerationController get generationController =>
    _generationController;

  List<Chat> get filteredChats {
  if (_searchQuery.trim().isEmpty) {
    return List.unmodifiable(_chats);
  }

  final query = _searchQuery.toLowerCase();

  return _chats.where((chat) {
    return chat.title.toLowerCase().contains(query);
  }).toList();
}


  int get currentChatIndex => _currentChatIndex;

  Chat get currentChat => _chats[_currentChatIndex];

  List<Message> get messages => currentChat.messages;

  bool get hasMessages => messages.isNotEmpty;

  GenerationState get generationState =>
    _generationState;

  bool get isGenerating =>
    _generationState.isGenerating;

  String _searchQuery = '';

  String get searchQuery => _searchQuery;

  Future<bool> isAiAvailable() {
    return _chatService.isReady();
  }

Future<void> _saveChats() async {
  try {
    await _repository.saveChats(_chats);
  } catch (_) {
    // Ignore persistence errors for now.
  }
}

Future<void> initialize() async {
  _availableModels = [];
  _selectedModel = null;

  try {
    final savedChats = await _repository.loadChats();

    if (savedChats.isNotEmpty) {
      _chats
        ..clear()
        ..addAll(savedChats);

      if (_currentChatIndex >= _chats.length) {
        _currentChatIndex = 0;
      }
    }
  } catch (_) {
    // Ignore persistence errors for now.
  }

  await _memoryService.initialize();

  final connected = await _chatService.isReady();

  if (!connected) {
    notifyListeners();
    return;
  }

  await refreshModels();

  notifyListeners();
}

  void switchChat(int index) {
    if (index == _currentChatIndex) return;
    if (index < 0 || index >= _chats.length) return;

    _currentChatIndex = index;
    notifyListeners();
  }

 Future<void> createNewChat() async {
    _chats.add(
      Chat(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: 'New Chat',
        createdAt: DateTime.now(),
        messages: const [],
      ),
    );

   _currentChatIndex = _chats.length - 1;

    await _saveChats();

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
    if (_generationState.isGenerating) return;

    final prompt = text.trim();

    final finalPrompt =
    await _chatPipeline.buildPrompt(
      userPrompt: prompt,
      history: currentChat.messages,
    );

    if (prompt.isEmpty) return;

    _generateChatTitle(prompt);

    _appendMessage(
      Message(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        text: prompt,
        isUser: true,
        createdAt: DateTime.now(),
      ),
    );
    
    _generationController.reset();

    _generationState = GenerationState.generating;
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
    prompt: finalPrompt,
    model: _selectedModel!,
  )) {
    if (_generationController.isCancelled) {
  _generationState = GenerationState.cancelled;
  break;
}

    if (chunk.isDone) {
      break;
    }

    buffer += chunk.text;

    _updateLastMessage(buffer);
    }
 } catch (e) {
  _generationState = GenerationState.error;
      _appendMessage(
        Message(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          text: 'Error: $e',
          isUser: false,
          createdAt: DateTime.now(),
        ),
      );
   } finally {
        if (_generationState !=
            GenerationState.error) {
          _generationState =
              GenerationState.completed;
        }

        await _saveChats();

        notifyListeners();

        _generationState = GenerationState.idle;
      }
  }

 Future<void> clearCurrentChat() async {
    _replaceCurrentChat(
      currentChat.copyWith(
        messages: const [],
      ),
    );

   await _saveChats();

     notifyListeners();
  }

  //stop generation if it's in progress
  void stopGeneration() {
  if (!_generationState.isGenerating) {
    return;
  }

  _generationController.cancel();

  notifyListeners();
}
  //search chats by title
  void searchChats(String query) {
  _searchQuery = query;
  notifyListeners();
}

  Future<void> renameCurrentChat(String title) async {
  final newTitle = title.trim();

  if (newTitle.isEmpty) {
    return;
  }

  _replaceCurrentChat(
    currentChat.copyWith(
      title: newTitle,
    ),
  );

  await _saveChats();

  notifyListeners();
}

 void _generateChatTitle(String firstPrompt) {
  if (currentChat.title != 'New Chat') {
    return;
  }

  final cleaned = firstPrompt.trim();

  if (cleaned.isEmpty) {
    return;
  }

  String title = cleaned;

  // Remove line breaks.
  title = title.replaceAll('\n', ' ');

  // Collapse multiple spaces.
  title = title.replaceAll(RegExp(r'\s+'), ' ');

  // Limit title length.
  if (title.length > 40) {
    title = '${title.substring(0, 40).trim()}...';
  }

  _replaceCurrentChat(
    currentChat.copyWith(
      title: title,
    ),
  );
}

  Future<void> deleteCurrentChat() async {
  if (_chats.length == 1) {
    await clearCurrentChat();
    return;
  }

  _chats.removeAt(_currentChatIndex);

  if (_currentChatIndex >= _chats.length) {
    _currentChatIndex = _chats.length - 1;
  }

  await _saveChats();

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