import 'package:flutter/material.dart';

import '../extensions/theme_extensions.dart';

enum EraButtonVariant {
  primary,
  secondary,
  ghost,
  danger,
}

class EraButton extends StatelessWidget {
  const EraButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = EraButtonVariant.primary,
    this.leading,
    this.trailing,
    this.loading = false,
    this.expanded = false,
  });

  final String label;

  final VoidCallback? onPressed;

  final EraButtonVariant variant;

  final Widget? leading;

  final Widget? trailing;

  final bool loading;

  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final radius = context.radius;

    final style = _style(colors);

    Widget child = Row(
      mainAxisSize:
          expanded ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (loading)
          const SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          )
        else if (leading != null)
          leading!,

        if (loading || leading != null)
          const SizedBox(width: 10),

        Flexible(
          child: Text(
            label,
            overflow: TextOverflow.ellipsis,
          ),
        ),

        if (trailing != null) ...[
          const SizedBox(width: 10),
          trailing!,
        ],
      ],
    );

    child = FilledButton(
      onPressed: loading ? null : onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: style.background,
        foregroundColor: style.foreground,
        disabledBackgroundColor:
            colors.surfaceVariant,
        disabledForegroundColor:
            colors.textDisabled,
        padding: context.spacing.inputPadding,
        shape: RoundedRectangleBorder(
          borderRadius: radius.md,
        ),
        elevation: 0,
      ),
      child: child,
    );

    if (expanded) {
      return SizedBox(
        width: double.infinity,
        child: child,
      );
    }

    return child;
  }

  _ButtonStyle _style(
    dynamic colors,
  ) {
    switch (variant) {
      case EraButtonVariant.primary:
        return _ButtonStyle(
          background: colors.primary,
          foreground: Colors.white,
        );

      case EraButtonVariant.secondary:
        return _ButtonStyle(
          background: colors.surfaceVariant,
          foreground: colors.textPrimary,
        );

      case EraButtonVariant.ghost:
        return _ButtonStyle(
          background: Colors.transparent,
          foreground: colors.textPrimary,
        );

      case EraButtonVariant.danger:
        return _ButtonStyle(
          background: colors.error,
          foreground: Colors.white,
        );
    }
  }
}

class _ButtonStyle {
  const _ButtonStyle({
    required this.background,
    required this.foreground,
  });

  final Color background;

  final Color foreground;
}