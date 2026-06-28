import '../../../features/chat/models/ai_response.dart';
import '../../../features/chat/models/ai_response_chunk.dart';

/// Base interface for every AI provider supported by Era.
///
/// Each provider is responsible for:
/// - Checking availability
/// - Listing installed models
/// - Generating responses
/// - Streaming responses
///
/// Examples include Ollama today, with other local or cloud
/// providers added later.
abstract class AIProvider {
  /// Human-readable provider name.
  String get providerName;

  /// Returns whether the provider is currently available.
  Future<bool> isAvailable();

  /// Returns every model exposed by this provider.
  Future<List<String>> getInstalledModels();

  /// Generates a complete response.
  Future<AIResponse> generateResponse({
    required String prompt,
    required String model,
  });

  /// Streams a response incrementally.
  ///
  /// Providers that don't support native streaming automatically
  /// fall back to the non-streaming implementation.
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

  /// Releases any resources owned by the provider.
  ///
  /// Most providers don't need cleanup, so the default
  /// implementation does nothing.
  Future<void> dispose() async {}

  // TODO: Expose provider capabilities (vision, embeddings, tools, etc.)
  // so the UI can automatically enable supported features.
}