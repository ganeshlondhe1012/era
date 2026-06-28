import '../context/chat_context.dart';
import '../models/chat_request.dart';

abstract interface class ContextProvider {
  const ContextProvider();

  Future<ChatContext> contribute(
    ChatRequest request,
    ChatContext context,
  );
}