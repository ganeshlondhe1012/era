import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/chat_controller.dart';

class PromptInput extends StatefulWidget {
  const PromptInput({super.key});

  @override
  State<PromptInput> createState() => _PromptInputState();
}

class _PromptInputState extends State<PromptInput> {
  final TextEditingController _controller = TextEditingController();

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

    context.read<ChatController>().sendUserMessage(text);

    _controller.clear();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final hasText = _controller.text.trim().isNotEmpty;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade800,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              minLines: 1,
              maxLines: 6,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: "Ask Era anything...",
                filled: true,
                fillColor: const Color(0xFF2A2A2A),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
              onSubmitted: (_) => _sendMessage(),
            ),
          ),

          const SizedBox(width: 12),

          SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: hasText ? _sendMessage : null,
              child: const Icon(Icons.send),
            ),
          ),
        ],
      ),
    );
  }
}