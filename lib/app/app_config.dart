class AppConfig {
  const AppConfig._();

  /// Ollama API endpoint.
  static const String ollamaBaseUrl = 'http://127.0.0.1:11434';

  static const String? defaultModel = null;

  /// API endpoint.
  static const String chatApi = '/api/chat';
}
