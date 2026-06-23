class AppConfig {
  const AppConfig._();

  /// Ollama API endpoint.
  static const String ollamaBaseUrl = 'http://127.0.0.1:11434';

  /// Default model.
/// No default model.
///
/// Era discovers installed Ollama models automatically.
/// The first available model (or the user's saved choice)
/// becomes the active model.
static const String? defaultModel = null;

  /// API endpoint.
  static const String chatApi = '/api/chat';
}