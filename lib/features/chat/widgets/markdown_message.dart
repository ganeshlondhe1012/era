import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

import 'code_block.dart';

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
      shrinkWrap: true,

      builders: {
        'code': _CodeElementBuilder(),
      },

      styleSheet: MarkdownStyleSheet(
        p: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          height: 1.6,
        ),

        h1: const TextStyle(
          color: Colors.white,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),

        h2: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),

        h3: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),

        strong: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),

        em: const TextStyle(
          color: Colors.white70,
          fontStyle: FontStyle.italic,
        ),

        blockquote: const TextStyle(
          color: Colors.grey,
          fontStyle: FontStyle.italic,
        ),

        listBullet: const TextStyle(
          color: Colors.white,
        ),

        code: const TextStyle(
          fontFamily: 'monospace',
          color: Colors.orangeAccent,
        ),
      ),
    );
  }
}

class _CodeElementBuilder extends MarkdownElementBuilder {
  @override
  Widget? visitElementAfter(
    dynamic element,
    TextStyle? preferredStyle,
  ) {
    final language =
        element.attributes['class']
                ?.replaceFirst('language-', '') ??
            '';

    final code = element.textContent;

    return CodeBlock(
      code: code,
      language: language,
    );
  }
}