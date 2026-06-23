import '../../chat/services/chat_service.dart';

import '../models/document_chunk.dart';

class RagChatService {
  RagChatService({
    required ChatService chatService,
  }) : _chatService = chatService;

  final ChatService _chatService;

  Future<String> buildPrompt({
    required String question,
    required List<DocumentChunk> chunks,
  }) async {
    final buffer = StringBuffer();

    buffer.writeln(
      'Answer the question using ONLY the information below.',
    );

    buffer.writeln();

    buffer.writeln('Context:');

    buffer.writeln();

    for (final chunk in chunks) {
      buffer.writeln(chunk.content);
      buffer.writeln();
    }

    buffer.writeln('Question:');

    buffer.writeln(question);

    return buffer.toString();
  }

  Stream streamAnswer({
    required String model,
    required String question,
    required List<DocumentChunk> chunks,
  }) async* {
    final prompt = await buildPrompt(
      question: question,
      chunks: chunks,
    );

    yield* _chatService.streamPrompt(
      prompt: prompt,
      model: model,
    );
  }
}