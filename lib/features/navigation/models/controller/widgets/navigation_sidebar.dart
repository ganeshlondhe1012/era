import 'package:flutter/material.dart';

import '../../../core/design/extensions/theme_extensions.dart';
import '../controller/navigation_controller.dart';
import 'navigation_item.dart';

/// ===============================================================
/// Era Navigation Sidebar
///
/// Main application navigation.
///
/// Responsibilities
/// ----------------
/// • Render destinations
/// • Header
/// • Footer
/// • Selection
///
/// Does NOT contain business logic.
/// ===============================================================
class NavigationSidebar extends StatelessWidget {
  const NavigationSidebar({
    super.key,
    required this.controller,
    this.header,
    this.footer,
    this.width,
  });

  final NavigationController controller;

  final Widget? header;

  final Widget? footer;

  final double? width;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final spacing = context.spacing;

    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return Container(
          width: width ?? 280,
          color: colors.surface,
          child: Column(
            children: [
              if (header != null)
                header!,

              Expanded(
                child: ListView.builder(
                  padding: spacing.sidebarPadding,
                  itemCount: controller.destinations.length,
                  itemBuilder: (context, index) {
                    final destination =
                        controller.destinations[index];

                    return NavigationItem(
                      destination: destination,
                      selected: controller.isSelected(
                        destination.id,
                      ),
                      onTap: () {
                        controller.navigateTo(
                          destination.id,
                        );
                      },
                    );
                  },
                ),
              ),

              if (footer != null)
                footer!,
            ],
          ),
        );
      },
    );
  }
}