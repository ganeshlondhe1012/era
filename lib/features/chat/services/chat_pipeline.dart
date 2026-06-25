import '../../memory/models/memory.dart';
import '../../memory/services/memory_extractor.dart';
import '../../memory/services/memory_service.dart';

import '../models/message.dart';

import 'chat_service.dart';
import 'conversation_context_builder.dart';
import 'prompt_builder.dart';

class ChatPipeline {
  ChatPipeline({
    required this._chatService,
    required this._memoryExtractor,
    required this._memoryService,
    required this._promptBuilder,
    ConversationContextBuilder? contextBuilder,
  })  : _contextBuilder =
            contextBuilder ??
                const ConversationContextBuilder();

  final ChatService _chatService;
  final MemoryExtractor _memoryExtractor;
  final MemoryService _memoryService;
  final PromptBuilder _promptBuilder;
  final ConversationContextBuilder _contextBuilder;

  Future<String> buildPrompt({
    required String userPrompt,
    required List<Message> history,
  }) async {
    final extracted =
        _memoryExtractor.extract(userPrompt);

    if (extracted.isNotEmpty) {
      await _memoryService.addMemories(extracted);
    }

    final List<Memory> memories =
        _memoryService.memories;

    final contextualPrompt =
        _contextBuilder.build(
      messages: history,
      prompt: userPrompt,
    );

    return _promptBuilder.build(
      userPrompt: contextualPrompt,
      memories: memories,
    );
  }

  ChatService get chatService => _chatService;
}