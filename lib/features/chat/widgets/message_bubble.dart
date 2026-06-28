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

   final theme = Theme.of(context);

final bubbleColor = isUser
    ? const Color(0xFF2563EB) 
    : theme.colorScheme.surfaceContainerHighest;
    
   
    return Padding(
     /* padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 6,
      ),*/
      padding: EdgeInsets.only(
            left: isUser ? 64 : 16,
            right: isUser ? 16 : 64,
            top: 6,
            bottom: 6,
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
                elevation: 0.5,
                borderRadius:
                    BorderRadius.circular(20),
                color: bubbleColor,
                child: Container(
              constraints: const BoxConstraints(
                maxWidth: 620,
              ),
              padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 12,
                  ),
              decoration: BoxDecoration(
                color: bubbleColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
               MessageContent(
                       text: message.text

                    ),
                  const SizedBox(height: 8),

                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      _formatTime(message.createdAt),
                     style: TextStyle(
                            fontSize: 12,
                            color: isUser
                                ? Colors.white70
                                : Theme.of(context).colorScheme.onSurfaceVariant,
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
            const SizedBox(width: 8),
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