import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

class MarkdownMessage extends StatelessWidget {
  const MarkdownMessage({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      selectable: true,
      data: text,
      styleSheet: MarkdownStyleSheet.fromTheme(
        Theme.of(context),
      ).copyWith(
        p: const TextStyle(
          fontSize: 15,
          height: 1.6,
        ),
        code: const TextStyle(
          fontFamily: 'Consolas',
          fontSize: 14,
        ),
      ),
    );
  }
}