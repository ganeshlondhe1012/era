import 'package:flutter/material.dart';

import '../../../core/design/extensions/theme_extensions.dart';
import '../models/navigation_destination.dart';

/// ===============================================================
/// Era Navigation Item
///
/// A reusable navigation entry.
///
/// Used by:
/// • Main Sidebar
/// • Settings Sidebar
/// • Documents Sidebar
/// • Agent Sidebar
/// • Plugin Sidebar
/// ===============================================================
class NavigationItem extends StatelessWidget {
  const NavigationItem({
    super.key,
    required this.destination,
    required this.selected,
    required this.onTap,
  });

  final NavigationDestination destination;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final spacing = context.spacing;
    final radius = context.radius;

    final foregroundColor =
        selected ? Colors.white : colors.textPrimary;

    final backgroundColor =
        selected ? colors.primary : Colors.transparent;

    return Padding(
      padding: EdgeInsets.only(
        bottom: spacing.xs,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: radius.md,
          onTap: destination.enabled ? onTap : null,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            padding: spacing.inputPadding,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: radius.md,
            ),
            child: Row(
              children: [
                Icon(
                  IconData(
                    selected
                        ? (destination.selectedIcon ??
                            destination.icon)
                        : destination.icon,
                    fontFamily: 'MaterialIcons',
                  ),
                  color: foregroundColor,
                ),

                SizedBox(width: spacing.md),

                Expanded(
                  child: Text(
                    destination.title,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(
                          color: foregroundColor,
                          fontWeight: selected
                              ? FontWeight.w600
                              : FontWeight.w500,
                        ),
                  ),
                ),

                if (destination.badgeCount != null)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spacing.xs,
                      vertical: spacing.xxxs,
                    ),
                    decoration: BoxDecoration(
                      color: selected
                          ? Colors.white24
                          : colors.surfaceVariant,
                      borderRadius: radius.full,
                    ),
                    child: Text(
                      destination.badgeCount.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(
                            color: foregroundColor,
                          ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}