import 'package:flutter/material.dart';

import '../extensions/theme_extensions.dart';

/// ===============================================================
/// Era Card
///
/// Base surface component used throughout the application.
///
/// Used by:
/// • Chat bubbles
/// • Settings sections
/// • Document cards
/// • Agent cards
/// • Plugin cards
/// • Dialog content
///
/// Never create Containers with custom decoration directly.
/// Use EraCard instead.
/// ===============================================================
class EraCard extends StatelessWidget {
  const EraCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderRadius,
    this.border,
    this.onTap,
    this.clipBehavior = Clip.antiAlias,
  });

  final Widget child;

  final EdgeInsetsGeometry? padding;

  final EdgeInsetsGeometry? margin;

  final Color? backgroundColor;

  final BorderRadius? borderRadius;

  final BoxBorder? border;

  final VoidCallback? onTap;

  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeProfile;

    Widget content = Container(
      margin: margin,
      padding: padding ?? theme.spacing.cardPadding,
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.colors.surface,
        borderRadius: borderRadius ?? theme.radius.lg,
        border: border,
      ),
      child: child,
    );

    if (onTap != null) {
      content = Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: borderRadius ?? theme.radius.lg,
          onTap: onTap,
          child: content,
        ),
      );
    }

    return ClipRRect(
      borderRadius: borderRadius ?? theme.radius.lg,
      clipBehavior: clipBehavior,
      child: content,
    );
  }
}