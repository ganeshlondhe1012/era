import '../context/chat_context.dart';
import '../models/chat_request.dart';

abstract interface class PipelineStage {
  const PipelineStage();

  Future<ChatContext> execute(
    ChatRequest request,
    ChatContext context,
  );
}