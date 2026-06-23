import '../../../core/ai/providers/ai_provider.dart';

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

    return ChatPipeline(
      chatService: chatService,
      promptBuilder: const PromptBuilder(),
    );
  }
}