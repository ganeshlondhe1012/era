import '../models/chat_request.dart';
import '../models/chat_response.dart';
import 'chat_service.dart';
import 'prompt_builder.dart';

class ChatPipeline {
  ChatPipeline({
    required ChatService chatService,
    PromptBuilder? promptBuilder,
  })  : _chatService = chatService,
        _promptBuilder = promptBuilder ?? const PromptBuilder();

  final ChatService _chatService;
  final PromptBuilder _promptBuilder;

  Future<ChatResponse> send({
    required ChatRequest request,
    Map<String, String> memories = const {},
    String? systemPrompt,
  }) async {
    final prompt = _promptBuilder.build(
      userPrompt: request.prompt,
      memories: memories,
      systemPrompt: systemPrompt,
    );

    final response = await _chatService.sendPrompt(
      prompt: prompt,
      model: request.model,
    );

    return ChatResponse(
      text: response.text,
      completed: response.completed,
      generationTime: response.generationTime,
      tokens: response.completionTokens,
    );
  }

  Stream<String> stream({
    required ChatRequest request,
  }) {
    return _chatService.streamPrompt(
      prompt: request.prompt,
      model: request.model,
    ).where((chunk) => !chunk.isDone).map((chunk) => chunk.text);
  }
}