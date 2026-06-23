import 'package:flutter/material.dart';

import '../models/message.dart';

import 'message_actions.dart';

import 'markdown_message.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.message,
  });

  final Message message;

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;

    final bubbleColor = isUser
        ? Theme.of(context).colorScheme.primary
        : const Color(0xFF2A2A2A);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 6,
      ),
      child: Row(
        mainAxisAlignment:
            isUser
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) ...[
            const CircleAvatar(
              radius: 18,
              child: Icon(Icons.smart_toy),
            ),
            const SizedBox(width: 12),
          ],

          Flexible(
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: 720,
              ),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: bubbleColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                                isUser
                    ? SelectableText(
                        message.text,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          height: 1.6,
                        ),
                      )
                    : MarkdownMessage(
                        text: message.text,
                      ),

                  const SizedBox(height: 8),

                  Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    _formatTime(message.createdAt),
                    style: TextStyle(
                      color: Colors.white.withOpacity(.55),
                      fontSize: 11,
                    ),
                  ),
                ),

                const SizedBox(height: 4),

                if (!isUser)
                  MessageActions(
                    text: message.text,
                    onRegenerate: () {
                      // TODO: Implement regenerate later.
                    },
                  ),
                ],
              ),
            ),
          ),

          if (isUser) ...[
            const SizedBox(width: 12),
            const CircleAvatar(
              radius: 18,
              child: Icon(Icons.person),
            ),
          ],
        ],
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final hour =
        dateTime.hour.toString().padLeft(2, '0');

    final minute =
        dateTime.minute.toString().padLeft(2, '0');

    return '$hour:$minute';
  }

  

  
}