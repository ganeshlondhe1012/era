import '../adapters/ai_model_adapter.dart';
import '../models/chat_request.dart';
import '../models/chat_response.dart';
import 'ai_chat_service.dart';

class DefaultAiChatService implements AiChatService {
  const DefaultAiChatService({
    required this.adapter,
  });

  final AiModelAdapter adapter;

  @override
  Future<ChatResponse> send(
    ChatRequest request,
  ) {
    return adapter.generate(request);
  }

  @override
  Stream<String> stream(
    ChatRequest request,
  ) {
    return adapter.stream(request);
  }
}