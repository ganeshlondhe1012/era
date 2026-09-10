import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:markdown/markdown.dart' as md;

import 'code_block.dart';

class MarkdownMessage extends StatelessWidget {
  const MarkdownMessage({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      data: text,
      selectable: true,
      softLineBreak: true,

      styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
        p: const TextStyle(fontSize: 15, height: 1.6),

        code: const TextStyle(fontFamily: 'Consolas', fontSize: 14),

        h1: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),

        h2: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),

        h3: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),

      builders: {'code': _CodeBuilder()},
    );
  }
}

class _CodeBuilder extends MarkdownElementBuilder {
  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    final language = element.attributes['class']?.replaceFirst('language-', '');

    final code = element.textContent;

    return CodeBlock(code: code, language: language);
  }
}
