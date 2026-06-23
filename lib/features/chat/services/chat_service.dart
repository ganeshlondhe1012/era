import '../../../core/ai/providers/ai_provider.dart';
import '../models/ai_response.dart';

/// Handles chat-related business logic.
///
/// Responsibilities:
///
/// - Send prompts
/// - Receive responses
/// - Validate provider availability
///
/// It intentionally knows nothing about:
///
/// - Flutter
/// - Widgets
/// - UI
/// - SQLite
///
/// Those responsibilities belong elsewhere.
class ChatService {
  final AIProvider _provider;

  const ChatService({
    required AIProvider provider,
  }) : _provider = provider;

  Future<bool> isReady() {
    return _provider.isAvailable();
  }

Future<List<String>> getInstalledModels() {
  return _provider.getInstalledModels();
}

  /// Sends a prompt to the configured AI provider.
  ///
  /// Returns the provider's complete response model.
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
}