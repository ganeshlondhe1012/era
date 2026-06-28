import '../context/chat_context.dart';
import '../models/chat_request.dart';
import 'context_provider.dart';

class AiPipeline {
  const AiPipeline({
    required this.providers,
  });

  final List<ContextProvider> providers;

  Future<ChatContext> execute(
    ChatRequest request,
  ) async {
    var context = const ChatContext();

    for (final provider in providers) {
      context = await provider.contribute(
        request,
        context,
      );
    }

    return context;
  }
}