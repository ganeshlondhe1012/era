import 'package:flutter/material.dart';

import '../../widgets/era_widget.dart';

/// ===============================================================
/// Era Toolbar
///
/// Standard desktop toolbar.
///
/// Used by:
/// • Chat
/// • Documents
/// • Memory
/// • Agents
/// • Plugins
/// • Settings
///
/// Future:
/// - Command Palette
/// - Breadcrumbs
/// - Search
/// - AI Status
/// - Window Controls
/// - Workspace Switcher
/// ===============================================================
class EraToolbar extends EraWidget {
  const EraToolbar({
    super.key,
    this.leading,
    this.title,
    this.subtitle,
    this.actions = const [],
    this.bottom,
    this.height = 64,
  });

  final Widget? leading;

  final Widget? title;

  final Widget? subtitle;

  final List<Widget> actions;

  final Widget? bottom;

  final double height;

  @override
  Widget buildEra(
    BuildContext context,
    EraWidgetContext design,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: design.colors.surface,
        border: Border(
          bottom: BorderSide(
            color: design.colors.divider,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: height,
            child: Padding(
              padding: design.spacing.sectionSpacing,
              child: Row(
                children: [
                  if (leading != null) ...[
                    leading!,
                    SizedBox(
                      width: design.spacing.md,
                    ),
                  ],

                  Expanded(
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        if (title != null)
                          DefaultTextStyle(
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!,
                            child: title!,
                          ),

                        if (subtitle != null)
                          DefaultTextStyle(
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!,
                            child: subtitle!,
                          ),
                      ],
                    ),
                  ),

                  ...actions,
                ],
              ),
            ),
          ),

          if (bottom != null)
            bottom!,
        ],
      ),
    );
  }
}