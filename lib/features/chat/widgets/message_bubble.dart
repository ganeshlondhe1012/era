import 'package:flutter/material.dart';

import '../models/message.dart';

import 'message_actions.dart';
import 'message/message_content.dart';

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
        : Theme.of(context).colorScheme.surfaceContainerHighest;
    
   
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
                        CircleAvatar(
                radius: 20,
                backgroundColor:
                    Theme.of(context)
                        .colorScheme
                        .primaryContainer,
                child: Icon(
                  isUser
                      ? Icons.person_rounded
                      : Icons.smart_toy_rounded,
                ),
              ),
            const SizedBox(width: 12),
          ],

                      
                        Material(
                elevation: 1,
                borderRadius:
                    BorderRadius.circular(20),
                color: bubbleColor,
                child: Container(
              constraints: const BoxConstraints(
                maxWidth: 680,
              ),
              padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
              decoration: BoxDecoration(
                color: bubbleColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
               MessageContent(
                       text: message.text,
                    
                          
                    ),
                  const SizedBox(height: 8),

                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      _formatTime(message.createdAt),
                      style: TextStyle(
                               color: Theme.of(context)
                              .colorScheme
                              .onSurfaceVariant,

                       ),
                      ),
                    ),
                  

                  if (!isUser) ...[
                    const SizedBox(height: 8),
                    MessageActions(
                      text: message.text,
                      onRegenerate: () {
                        // TODO: Implement regenerate.
                      },
                    ),
                  ],
                ],
              ),
            ),
          ),

          if (isUser) ...[
            const SizedBox(width: 12),
                          CircleAvatar(
                  radius: 20,
                  backgroundColor:
                      Theme.of(context)
                          .colorScheme
                          .primaryContainer,
                  child: Icon(
                    isUser
                        ? Icons.person_rounded
                        : Icons.smart_toy_rounded,
                  ),
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