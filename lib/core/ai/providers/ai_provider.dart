import '../../../features/chat/models/ai_response.dart';

/// Base abstraction for all AI backends.
///
/// Current:
/// - Ollama
///
/// Future:
/// - LM Studio
/// - llama.cpp
/// - OpenAI
/// - Gemini
abstract class AIProvider {
  /// Provider display name.
  String get providerName;

  /// Returns true if the provider is available.
  Future<bool> isAvailable();

  /// Returns every installed model.
  ///
  /// Example:
  /// [
  ///   "deepseek-coder:6.7b",
  ///   "phi3:mini",
  ///   "llama3:8b"
  /// ]
  Future<List<String>> getInstalledModels();

  /// Generates a response using the specified model.
  Future<AIResponse> generateResponse({
    required String prompt,
    required String model,
  });

  /// Releases any resources held by the provider.
  Future<void> dispose() async {}
}