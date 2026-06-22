import 'package:flutter/material.dart';

import '../models/message.dart';

class MessageBubble extends StatelessWidget {
  final Message message;

  const MessageBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final bool isUser = message.isUser;

    return Align(
      alignment: isUser
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 700,
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 6,
        ),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isUser
              ? Colors.blue
              : const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(14),
        ),
        child: SelectableText(
          message.text,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.white,
            height: 1.5,
          ),
        ),
      ),
    );
  }
}