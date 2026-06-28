import '../models/chat_request.dart';
import '../models/chat_response.dart';

abstract interface class AiModelAdapter {
  Future<ChatResponse> generate(
    ChatRequest request,
  );

  Stream<String> stream(
    ChatRequest request,
  );
}