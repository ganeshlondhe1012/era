import '../../documents/models/document_attachment.dart';
import '../../memory/models/memory.dart';
import '../../memory/services/memory_extractor.dart';
import '../../memory/services/memory_service.dart';
import '../models/message.dart';
import 'chat_service.dart';
import 'context/chat_context.dart';
import 'prompt_builder.dart';

class ChatPipeline {
  ChatPipeline({
    required this._chatService,
    required this._memoryExtractor,
    required this._memoryService,
    required this._promptBuilder,
  });

  final ChatService _chatService;
  final MemoryExtractor _memoryExtractor;
  final MemoryService _memoryService;
  final PromptBuilder _promptBuilder;

  /// Builds the prompt that will be sent to the model.
  ///
  /// this preserves the current behaviour while exposing
  /// a scalable ChatContext API.
  String buildPrompt({
    required String userPrompt,
    List<Message> history = const [],
    List<Memory> memories = const [],
    List<DocumentAttachment> documents = const [],
    String? systemPrompt,
  }) {
    final context = ChatContext(
  userPrompt: userPrompt,
  history: history,
  memories: memories,
  documents: documents,
  systemPrompt: systemPrompt,
);

return _promptBuilder.build(context);
  }

  ChatService get chatService => _chatService;

  MemoryExtractor get memoryExtractor => _memoryExtractor;

  MemoryService get memoryService => _memoryService;
}