import '../../../features/chat/models/ai_response.dart';
import '../../../features/chat/services/ollama_service.dart';
import 'ai_provider.dart';

class OllamaProvider implements AIProvider {
  OllamaProvider({
    required OllamaService service,
   
  }) : _service = service;

  final OllamaService _service;



  @override
  String get providerName => 'Ollama';

  @override
 

  @override
  Future<bool> isAvailable() {
    return _service.isAvailable();
  }

  @override
Future<AIResponse> generateResponse({
  required String prompt,
  required String model,
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
Future<List<String>> getInstalledModels() {
  return _service.getInstalledModels();
}

  @override
  Future<void> dispose() async {
    _service.dispose();
  }
}