import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../../core/design/extensions/theme_extensions.dart';

/// ===============================================================
/// Markdown Message
///
/// Responsible ONLY for rendering markdown.
///
/// Future
/// ------
/// • Code highlighting
/// • Mermaid
/// • LaTeX
/// • Tables
/// • Images
/// • Citations
/// • Tool calls
/// • Thinking blocks
/// • Copyable code
/// ===============================================================
class MarkdownMessage extends StatelessWidget {
  const MarkdownMessage({
    super.key,
    required this.text,
    this.selectable = true,
    this.shrinkWrap = true,
  });

  final String text;

  final bool selectable;

  final bool shrinkWrap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return MarkdownBody(
      data: text,
      selectable: selectable,
      shrinkWrap: shrinkWrap,
      styleSheet: MarkdownStyleSheet(
        p: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: colors.textPrimary,
            ),
        h1: Theme.of(context).textTheme.headlineMedium,
        h2: Theme.of(context).textTheme.headlineSmall,
        h3: Theme.of(context).textTheme.titleLarge,
        code: TextStyle(
          fontFamily: 'Consolas',
          fontSize: 13,
          color: colors.textPrimary,
        ),
        codeblockDecoration: BoxDecoration(
          color: colors.surfaceVariant,
          borderRadius: context.radius.md,
        ),
        blockquoteDecoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: colors.primary,
              width: 4,
            ),
          ),
        ),
      ),
      onTapLink: (text, href, title) {
        // URL launcher will be added later.
      },
      builders: {
        // Custom markdown builders
        // will be registered here later.
      },
    );
  }
}