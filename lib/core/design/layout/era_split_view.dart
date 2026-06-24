import 'package:flutter/material.dart';

import '../widgets/era_widget.dart';

/// ===============================================================
/// Era Split View
///
/// Adaptive desktop layout.
///
/// Future
/// -------
/// • Resizable panes
/// • Drag handle
/// • Collapse
/// • Multi pane
/// • Workspace support
/// • Saved layouts
/// ===============================================================
class EraSplitView extends EraWidget {
  const EraSplitView({
    super.key,
    required this.primary,
    required this.secondary,
    this.primaryFlex = 1,
    this.secondaryFlex = 3,
    this.spacing,
  });

  final Widget primary;

  final Widget secondary;

  final int primaryFlex;

  final int secondaryFlex;

  final double? spacing;

  @override
  Widget buildEra(
    BuildContext context,
    EraWidgetContext design,
  ) {
    return Row(
      children: [
        Expanded(
          flex: primaryFlex,
          child: primary,
        ),

        SizedBox(
          width: spacing ??
              design.spacing.md,
        ),

        Expanded(
          flex: secondaryFlex,
          child: secondary,
        ),
      ],
    );
  }
}