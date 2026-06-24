import 'package:flutter/material.dart';

import '../../../core/design/extensions/theme_extensions.dart';
import '../models/navigation_action.dart';

/// ===============================================================
/// Era Navigation Footer
///
/// Future:
/// • Settings
/// • Updates
/// • User Profile
/// • Theme Switcher
/// • Logout
/// • Plugin Actions
/// ===============================================================
class NavigationFooter extends StatelessWidget {
  const NavigationFooter({
    super.key,
    required this.actions,
    required this.onActionSelected,
  });

  final List<NavigationAction> actions;

  final ValueChanged<NavigationAction> onActionSelected;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final spacing = context.spacing;
    final radius = context.radius;

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(
          top: BorderSide(
            color: colors.divider,
          ),
        ),
      ),
      padding: spacing.sidebarPadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: actions.map((action) {
          final foreground = action.danger
              ? colors.error
              : colors.textPrimary;

          return Padding(
            padding: EdgeInsets.only(
              bottom: spacing.xs,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: radius.md,
                onTap: action.enabled
                    ? () => onActionSelected(action)
                    : null,
                child: Padding(
                  padding: spacing.inputPadding,
                  child: Row(
                    children: [
                      Icon(
                        IconData(
                          action.icon,
                          fontFamily: 'MaterialIcons',
                        ),
                        color: foreground,
                      ),

                      SizedBox(width: spacing.md),

                      Expanded(
                        child: Text(
                          action.label,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                color: foreground,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}