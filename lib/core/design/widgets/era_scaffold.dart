import 'package:flutter/material.dart';

import 'era_widget.dart';

/// ===============================================================
/// Era Scaffold
///
/// Standard application shell.
///
/// Every screen in Era must use this widget.
///
/// Future Features
/// ----------------
/// • Adaptive layout
/// • Navigation rail
/// • Toolbar
/// • Status bar
/// • Command palette overlay
/// • Notification overlay
/// • Global loading
/// • Drag & Drop
/// • Multi-window support
/// • Plugin regions
/// ===============================================================
class EraScaffold extends EraWidget {
  const EraScaffold({
    super.key,
    required this.body,
    this.sidebar,
    this.header,
    this.footer,
    this.floatingActionButton,
    this.maxContentWidth,
    this.safeArea = true,
  });

  final Widget body;

  final Widget? sidebar;

  final Widget? header;

  final Widget? footer;

  final Widget? floatingActionButton;

  final double? maxContentWidth;

  final bool safeArea;

  @override
  Widget buildEra(
    BuildContext context,
    EraWidgetContext design,
  ) {
    Widget content = Column(
      children: [
        if (header != null) header!,
        Expanded(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: maxContentWidth ?? double.infinity,
              ),
              child: body,
            ),
          ),
        ),
        if (footer != null) footer!,
      ],
    );

    if (safeArea) {
      content = SafeArea(
        child: content,
      );
    }

    return Scaffold(
      backgroundColor: design.colors.background,
      floatingActionButton: floatingActionButton,
      body: Row(
        children: [
          if (sidebar != null) sidebar!,
          Expanded(
            child: content,
          ),
        ],
      ),
    );
  }
}