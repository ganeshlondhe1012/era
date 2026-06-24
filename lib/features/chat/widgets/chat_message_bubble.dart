import 'package:flutter/material.dart';

import '../../../core/design/extensions/theme_extensions.dart';
import '../../../core/design/widgets/era_card.dart';
import '../models/message.dart';
import 'markdown_message.dart';

/// ===============================================================
/// Chat Message Bubble
///
/// Standard conversation message.
///
/// Future
/// ------
/// • Markdown
/// • Code Blocks
/// • Images
/// • Citations
/// • Tool Calls
/// • Thinking
/// • Editing
/// • Reactions
/// • Retry
/// ===============================================================
class ChatMessageBubble extends StatelessWidget {
  const ChatMessageBubble({
    super.key,
    required this.message,
    this.showTimestamp = false,
    this.showAvatar = true,
  });

  final Message message;

  final bool showTimestamp;

  final bool showAvatar;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final spacing = context.spacing;

    final isUser = message.isUser;

    final bubbleColor = isUser
        ? colors.chatUserBubble
        : colors.chatAssistantBubble;

    final textColor =
        isUser ? Colors.white : colors.textPrimary;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: isUser
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        if (!isUser && showAvatar) ...[
          CircleAvatar(
            radius: 18,
            child: const Icon(
              Icons.smart_toy_outlined,
              size: 18,
            ),
          ),
          SizedBox(width: spacing.md),
        ],

        Flexible(
          child: EraCard(
            backgroundColor: bubbleColor,
            child: DefaultTextStyle(
              style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(
                        color: textColor,
                      ) ??
                  TextStyle(
                    color: textColor,
                  ),
              child: MarkdownMessage(
                text: message.text,
              ),
            ),
          ),
        ),

        if (isUser && showAvatar) ...[
          SizedBox(width: spacing.md),
          const CircleAvatar(
            radius: 18,
            child: Icon(
              Icons.person_outline,
              size: 18,
            ),
          ),
        ],
      ],
    );
  }
}