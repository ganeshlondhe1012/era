import '../models/chat_request.dart';
import '../models/chat_response.dart';

abstract interface class AiChatService {
  Future<ChatResponse> send(
    ChatRequest request,
  );

  Stream<String> stream(
    ChatRequest request,
  );
}