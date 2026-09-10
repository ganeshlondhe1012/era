import '../../../core/ai/providers/ai_provider.dart';

import '../models/ai_response.dart';
import '../models/ai_response_chunk.dart';
import '../models/chat_request.dart';
import '../models/chat_response.dart';

/// Handles chat-related business logic.
///
/// Responsibilities:
/// - Validate prompts
/// - Check provider availability
/// - Send prompts
/// - Stream prompts
///
/// It intentionally knows nothing about:
/// - Flutter
/// - Widgets
/// - UI
/// - Storage
class ChatService {
  const ChatService({required this._provider});

  final AIProvider _provider;

  Future<bool> isReady() {
    return _provider.isAvailable();
  }

  Future<List<String>> getInstalledModels() {
    return _provider.getInstalledModels();
  }

  /// Existing API (kept for backward compatibility)
  Future<AIResponse> sendPrompt({
    required String prompt,
    required String model,
  }) async {
    final cleanedPrompt = prompt.trim();

    if (cleanedPrompt.isEmpty) {
      throw Exception('Prompt cannot be empty.');
    }

    return _provider.generateResponse(prompt: cleanedPrompt, model: model);
  }

  /// New pipeline API
  Future<ChatResponse> send(ChatRequest request) async {
    final response = await sendPrompt(
      prompt: request.prompt,
      model: request.model,
    );

    return ChatResponse(
      text: response.text,
      completed: response.completed,
      generationTime: response.generationTime,
      tokens: response.completionTokens,
    );
  }

  /// Existing streaming API
  Stream<AIResponseChunk> streamPrompt({
    required String prompt,
    required String model,
  }) {
    final cleanedPrompt = prompt.trim();

    if (cleanedPrompt.isEmpty) {
      return Stream.error(Exception('Prompt cannot be empty.'));
    }

    return _provider.generateResponseStream(
      prompt: cleanedPrompt,
      model: model,
    );
  }

  /// New pipeline streaming API
  Stream<AIResponseChunk> stream(ChatRequest request) {
    return streamPrompt(prompt: request.prompt, model: request.model);
  }
}
