import '../../../core/ai/providers/ai_provider.dart';

import '../models/ai_response.dart';
import '../models/ai_response_chunk.dart';

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
  const ChatService({
    required AIProvider provider,
  }) : _provider = provider;

  final AIProvider _provider;

  Future<bool> isReady() {
    return _provider.isAvailable();
  }

  Future<List<String>> getInstalledModels() {
    return _provider.getInstalledModels();
  }

  /// Sends a prompt and waits for the complete response.
  Future<AIResponse> sendPrompt({
    required String prompt,
    required String model,
  }) async {
    final cleanedPrompt = prompt.trim();

    if (cleanedPrompt.isEmpty) {
      throw Exception('Prompt cannot be empty.');
    }

    return _provider.generateResponse(
      prompt: cleanedPrompt,
      model: model,
    );
  }

  /// Streams a response incrementally.
  Stream<AIResponseChunk> streamPrompt({
    required String prompt,
    required String model,
  }) {
    final cleanedPrompt = prompt.trim();

    if (cleanedPrompt.isEmpty) {
      return Stream.error(
        Exception('Prompt cannot be empty.'),
      );
    }

    return _provider.generateResponseStream(
      prompt: cleanedPrompt,
      model: model,
    );
  }
}