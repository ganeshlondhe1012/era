
import 'package:era/features/chat/services/ollama_service.dart';
import '../models/chat_request.dart';
import '../models/chat_response.dart';
import 'ai_model_adapter.dart';

class OllamaAdapter implements AiModelAdapter {
  const OllamaAdapter({
    required this.service,
    required this.model,
  });

  final OllamaService service;

  final String model;

  @override
  Future<ChatResponse> generate(
    ChatRequest request,
  ) async {
    final response =
        await service.generateResponse(
      prompt: request.text,
      model: model,
    );

    return ChatResponse(
      text: response,
    );
  }

  @override
  Stream<String> stream(
    ChatRequest request,
  ) {
    return service.generateResponseStream(
      prompt: request.text,
      model: model,
    );
  }
}