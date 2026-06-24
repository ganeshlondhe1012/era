import 'package:flutter/material.dart';

import 'era_widget.dart';

/// ===============================================================
/// Era Navigation Rail
///
/// Reusable desktop navigation.
///
/// Used by:
/// • Main Navigation
/// • Settings Navigation
/// • Agent Navigation
/// • Plugin Navigation
///
/// Never use Flutter NavigationRail directly.
/// ===============================================================

class EraNavigationItem {
  const EraNavigationItem({
    required this.id,
    required this.title,
    required this.icon,
    this.selectedIcon,
    this.badge,
    this.enabled = true,
  });

  final String id;
  final String title;
  final IconData icon;
  final IconData? selectedIcon;
  final int? badge;
  final bool enabled;
}

class EraNavigationRail extends EraWidget {
  const EraNavigationRail({
    super.key,
    required this.items,
    required this.selectedId,
    required this.onSelected,
    this.header,
    this.footer,
    this.width = 260,
  });

  final List<EraNavigationItem> items;

  final String selectedId;

  final ValueChanged<String> onSelected;

  final Widget? header;

  final Widget? footer;

  final double width;

  @override
  Widget buildEra(
    BuildContext context,
    EraWidgetContext design,
  ) {
    return Container(
      width: width,
      color: design.colors.surface,
      child: Column(
        children: [
          if (header != null)
            header!,

          Expanded(
            child: ListView.builder(
              padding: design.spacing.sidebarPadding,
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];

                final selected =
                    item.id == selectedId;

                return Padding(
                  padding: EdgeInsets.only(
                    bottom: design.spacing.xs,
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius:
                          design.radius.md,
                      onTap: item.enabled
                          ? () => onSelected(item.id)
                          : null,
                      child: AnimatedContainer(
                        duration: const Duration(
                          milliseconds: 180,
                        ),
                        padding:
                            design.spacing.inputPadding,
                        decoration: BoxDecoration(
                          color: selected
                              ? design.colors.primary
                              : Colors.transparent,
                          borderRadius:
                              design.radius.md,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              selected
                                  ? (item.selectedIcon ??
                                      item.icon)
                                  : item.icon,
                              color: selected
                                  ? Colors.white
                                  : design.colors
                                      .textSecondary,
                            ),

                            SizedBox(
                              width:
                                  design.spacing.md,
                            ),

                            Expanded(
                              child: Text(
                                item.title,
                                overflow:
                                    TextOverflow
                                        .ellipsis,
                                style: TextStyle(
                                  color: selected
                                      ? Colors.white
                                      : design
                                          .colors
                                          .textPrimary,
                                ),
                              ),
                            ),

                            if (item.badge != null)
                              CircleAvatar(
                                radius: 10,
                                child: Text(
                                  item.badge
                                      .toString(),
                                  style:
                                      const TextStyle(
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          if (footer != null)
            footer!,
        ],
      ),
    );
  }
}