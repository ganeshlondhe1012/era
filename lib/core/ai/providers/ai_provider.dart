import '../../../features/chat/models/ai_response.dart';

/// Base contract implemented by every AI backend.
///
/// Examples:
/// - Ollama
/// - LM Studio
/// - llama.cpp
/// - OpenAI
/// - Gemini
///
/// The rest of the application must never know which
/// implementation is being used.
abstract class AIProvider {
  /// Display name shown in the UI.
  String get providerName;

  /// Active model name.
  String get modelName;

  /// Returns whether the provider is currently available.
  ///
  /// Example:
  /// - Ollama server running
  /// - LM Studio started
  Future<bool> isAvailable();

  /// Generates a complete response.
  ///
  /// Returning an [AIResponse] keeps the controller independent
  /// from any specific AI backend.
  Future<AIResponse> generateResponse({
    required String prompt,
  });

  /// Optional cleanup hook.
  ///
  /// Future providers may use:
  /// - HTTP clients
  /// - Streams
  /// - WebSockets
  /// - Native resources
  Future<void> dispose() async {}
}