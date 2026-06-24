import 'package:flutter/material.dart';

import '../../../core/design/extensions/theme_extensions.dart';
import '../models/message.dart';
import 'chat_message_bubble.dart';

/// ===============================================================
/// Chat Message List
///
/// Standard conversation timeline.
///
/// Future
/// ------
/// • Streaming
/// • Markdown
/// • Code blocks
/// • Images
/// • Citations
/// • Documents
/// • Voice
/// • Editing
/// • Selection
/// • Context Menu
/// ===============================================================
class ChatMessageList extends StatelessWidget {
  const ChatMessageList({
    super.key,
    required this.messages,
    this.controller,
    this.padding,
    this.reverse = false,
  });

  final List<Message> messages;

  final ScrollController? controller;

  final EdgeInsetsGeometry? padding;

  final bool reverse;

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;

    if (messages.isEmpty) {
      return Center(
        child: Text(
          'Start a conversation',
          style: Theme.of(context)
              .textTheme
              .titleMedium,
        ),
      );
    }

    return ListView.separated(
      controller: controller,
      reverse: reverse,
      padding: padding ??
          EdgeInsets.all(spacing.lg),
      itemCount: messages.length,
      separatorBuilder: (_, __) =>
          SizedBox(height: spacing.md),
      itemBuilder: (context, index) {
        final message = messages[index];

        return ChatMessageBubble(
          message: message,
        );
      },
    );
  }
}