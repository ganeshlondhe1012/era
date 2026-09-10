import '../../../memory/models/memory.dart';
import '../../models/message.dart';
import '../../../documents/models/document_attachment.dart';

class ChatContext {
  const ChatContext({
    required this.userPrompt,
    this.history = const [],
    this.memories = const [],
    this.documents = const [],
    this.systemPrompt,
  });

  final String userPrompt;

  final List<Message> history;

  final List<Memory> memories;

  final List<DocumentAttachment> documents;

  final String? systemPrompt;

  bool get hasHistory => history.isNotEmpty;

  bool get hasMemories => memories.isNotEmpty;

  bool get hasDocuments => documents.isNotEmpty;

  bool get hasSystemPrompt =>
      systemPrompt != null && systemPrompt!.trim().isNotEmpty;
}
