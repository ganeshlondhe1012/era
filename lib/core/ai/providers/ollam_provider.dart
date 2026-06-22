import '../../../features/chat/models/ai_response.dart';
import '../../../features/chat/services/ollama_service.dart';
import 'ai_provider.dart';

class OllamaProvider implements AIProvider {
  OllamaProvider({
    required OllamaService service,
    this.model = 'phi3:mini',
  }) : _service = service;

  final OllamaService _service;

  final String model;

  @override
  String get providerName => 'Ollama';

  @override
  String get modelName => model;

  @override
  Future<bool> isAvailable() {
    return _service.isAvailable();
  }

  @override
  Future<AIResponse> generateResponse({
    required String prompt,
  }) async {
    final stopwatch = Stopwatch()..start();

    final text = await _service.generateResponse(
      prompt: prompt,
      model: model,
    );

    stopwatch.stop();

    return AIResponse(
      text: text,
      model: model,
      completed: true,
      generationTime: stopwatch.elapsed,
      promptTokens: null,
      completionTokens: null,
    );
  }

  @override
  Future<void> dispose() async {
    _service.dispose();
  }
}