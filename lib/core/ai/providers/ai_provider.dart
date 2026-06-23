import '../../../features/chat/models/ai_response.dart';
import '../../../features/chat/models/ai_response_chunk.dart';

/// Base abstraction for every AI backend.
///
/// Current:
/// - Ollama
///
/// Future:
/// - LM Studio
/// - llama.cpp
/// - OpenAI
/// - Gemini
/// - Claude
abstract class AIProvider {
  /// Display name.
  String get providerName;

  /// Returns true if the provider is available.
  Future<bool> isAvailable();

  /// Returns every installed model.
  Future<List<String>> getInstalledModels();

  /// Generates a complete response.
  ///
  /// This API is kept for backward compatibility.
  Future<AIResponse> generateResponse({
    required String prompt,
    required String model,
  });

  /// Streams a response incrementally.
  ///
  /// Default implementation falls back to the non-streaming API
  /// so providers continue to work until they implement native
  /// streaming support.
  Stream<AIResponseChunk> generateResponseStream({
    required String prompt,
    required String model,
  }) async* {
    final response = await generateResponse(
      prompt: prompt,
      model: model,
    );

    yield AIResponseChunk(
      text: response.text,
      isDone: true,
    );
  }

  /// Releases resources.
  Future<void> dispose() async {}
}