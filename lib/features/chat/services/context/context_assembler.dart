import '../../models/message.dart';
import '../../../memory/models/memory.dart';
import '../../../documents/models/document_attachment.dart';

import 'chat_context.dart';

class ContextAssembler {
  const ContextAssembler();

  ChatContext assemble({
    required String userPrompt,
    List<Message> history = const [],
    List<Memory> memories = const [],
    List<DocumentAttachment> documents = const [],
    String? systemPrompt,
  }) {
    return ChatContext(
      userPrompt: userPrompt,
      history: history,
      memories: memories,
      documents: documents,
      systemPrompt: systemPrompt,
    );
  }
}