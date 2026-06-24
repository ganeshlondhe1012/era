import 'package:flutter/material.dart';

import '../../../core/design/extensions/theme_extensions.dart';

/// ===============================================================
/// Era Navigation Header
///
/// Desktop sidebar header.
///
/// Future:
/// • Workspace selector
/// • Current model
/// • AI status
/// • User avatar
/// • Notifications
/// • Sync status
/// ===============================================================
class NavigationHeader extends StatelessWidget {
  const NavigationHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.logo,
    this.trailing,
    this.onTap,
  });

  final String title;

  final String? subtitle;

  final Widget? logo;

  final Widget? trailing;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final spacing = context.spacing;
    final radius = context.radius;

    Widget child = Container(
      padding: spacing.cardPadding,
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(
          bottom: BorderSide(
            color: colors.divider,
          ),
        ),
      ),
      child: Row(
        children: [
          logo ??
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: colors.primary,
                  borderRadius: radius.md,
                ),
                alignment: Alignment.center,
                child: const Text(
                  'E',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),

          SizedBox(width: spacing.md),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(
                        color: colors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(
                          color: colors.textSecondary,
                        ),
                  ),
              ],
            ),
          ),

          if (trailing != null) ...[
            SizedBox(width: spacing.sm),
            trailing!,
          ],
        ],
      ),
    );

    if (onTap != null) {
      child = Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: radius.md,
          child: child,
        ),
      );
    }

    return child;
  }
}