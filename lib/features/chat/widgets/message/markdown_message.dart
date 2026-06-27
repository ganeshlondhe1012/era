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
      data: text,
      selectable: true,
      softLineBreak: true,

      styleSheet: MarkdownStyleSheet.fromTheme(
        Theme.of(context),
      ).copyWith(
        p: Theme.of(context)
            .textTheme
            .bodyMedium,

        code: TextStyle(
          fontFamily: 'Consolas',
          fontSize: 13,
          backgroundColor:
              Theme.of(context)
                  .colorScheme
                  .surfaceContainerHighest,
        ),

        codeblockDecoration: BoxDecoration(
          color: Theme.of(context)
              .colorScheme
              .surfaceContainerHighest,
          borderRadius:
              BorderRadius.circular(12),
        ),
      ),
    );
  }
}