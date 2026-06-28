import 'package:flutter/material.dart';

import 'markdown_message.dart';

class MessageContent extends StatelessWidget {
  const MessageContent({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return MarkdownMessage(text: text);
  }
}
