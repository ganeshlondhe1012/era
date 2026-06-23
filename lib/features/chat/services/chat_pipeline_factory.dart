import '../../../core/ai/providers/ai_provider.dart';

import '../../memory/repository/local_repository.dart';
import '../../memory/services/memory_extractor.dart';
import '../../memory/services/memory_service.dart';

import 'chat_pipeline.dart';
import 'chat_service.dart';
import 'prompt_builder.dart';

class ChatPipelineFactory {
  const ChatPipelineFactory._();

  static ChatPipeline create({
    required AIProvider provider,
  }) {
    final chatService = ChatService(
      provider: provider,
    );

    final memoryService = MemoryService(
      repository: LocalMemoryRepository(),
    );

    return ChatPipeline(
      chatService: chatService,
      memoryExtractor: const MemoryExtractor(),
      memoryService: memoryService,
      promptBuilder: const PromptBuilder(),
    );
  }
}