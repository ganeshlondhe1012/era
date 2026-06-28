import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/chat_controller.dart';

import '../../documents/controllers/document_controller.dart';
import '../../documents/models/document_attachment.dart';
import '../../documents/services/document_picker_service.dart';
import '../../documents/services/document_text_extractor.dart';
import '../../documents/widgets/attached_document_card.dart';

class PromptInput extends StatefulWidget {
  const PromptInput({super.key});

  @override
  State<PromptInput> createState() => _PromptInputState();
}

class _PromptInputState extends State<PromptInput> {
  final TextEditingController _controller = TextEditingController();

  final _picker = const DocumentPickerService();

  final _extractor = const DocumentTextExtractor();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) {
      return;
    }

    context.read<ChatController>().sendMessage(text);

    _controller.clear();

    setState(() {});
  }

  Future<void> _pickDocument() async {
    try {
      final file = await _picker.pickDocument();

      if (file == null || file.path == null) {
        return;
      }

      final text = await _extractor.extract(path: file.path!);

      final document = DocumentAttachment(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: file.name,
        path: file.path!,
        mimeType: file.extension ?? '',
        text: text,
        uploadedAt: DateTime.now(),
      );

      if (!mounted) return;

      await context.read<DocumentController>().attach(document);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to attach document.\n$e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatController>(
      builder: (context, controller, child) {
        final hasText = _controller.text.trim().isNotEmpty;

        final isGenerating = controller.isGenerating;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            border: Border(top: BorderSide(color: Colors.grey.shade800)),
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Consumer<DocumentController>(
                builder: (context, documentController, _) {
                  if (!documentController.hasAttachment) {
                    return const SizedBox.shrink();
                  }

                  return AttachedDocumentCard(
                    document: documentController.attachment!,
                    onRemove: documentController.remove,
                  );
                },
              ),

              Row(
                children: [
                  IconButton(
                    tooltip: 'Attach Document',
                    icon: const Icon(Icons.attach_file_rounded),
                    onPressed: isGenerating ? null : _pickDocument,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      enabled: !isGenerating,
                      minLines: 1,
                      maxLines: 8,
                      onChanged: (_) => setState(() {}),
                      decoration: InputDecoration(
                        hintText: isGenerating
                            ? 'Era is generating...'
                            : 'Ask Era anything...',
                        filled: true,
                        fillColor: Theme.of(
                          context,
                        ).colorScheme.surfaceContainerHighest,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: Theme.of(context).dividerColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                      onSubmitted: (_) {
                        if (!isGenerating) {
                          _sendMessage();
                        }
                      },
                    ),
                  ),

                  const SizedBox(width: 8),

                  SizedBox(
                    width: 48,
                    height: 48,
                    child: FilledButton(
                      onPressed: isGenerating
                          ? controller.stopGeneration
                          : (hasText ? _sendMessage : null),
                      style: FilledButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: EdgeInsets.zero,
                        backgroundColor: isGenerating ? Colors.red : null,
                      ),
                      child: Icon(
                        isGenerating ? Icons.stop_rounded : Icons.send_rounded,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
