import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/chat_controller.dart';

class PromptInput extends StatefulWidget {
  const PromptInput({super.key});

  @override
  State<PromptInput> createState() => _PromptInputState();
}

class _PromptInputState extends State<PromptInput> {
  final TextEditingController _controller =
      TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatController>(
      builder: (context, controller, child) {
        final hasText =
            _controller.text.trim().isNotEmpty;

        final isGenerating =
            controller.isGenerating;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
            border: Border(
              top: BorderSide(
                color: Colors.grey.shade800,
              ),
            ),
          ),
                
          child: Row(
           
            children: [
                              IconButton(
                  tooltip: 'Attach Document',
                  icon: const Icon(Icons.attach_file_rounded),
                  onPressed: isGenerating
                      ? null
                      : () {
                          // TODO: Document upload
                        },
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
                    fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
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
                    contentPadding:
                        const EdgeInsets.symmetric(
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

             

             SizedBox(
                    width: 42,
                    height: 52,
                    child: FilledButton(
                      onPressed: hasText ? _sendMessage : null,
                      style: FilledButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: EdgeInsets.zero,
                      ),
                      child: const Icon(Icons.send_rounded),
                    ),
                  ),
            ],
          ),
        );
      },
    );
  }
}