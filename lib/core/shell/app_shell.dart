import 'package:flutter/material.dart';

import '../design/widgets/era_widget.dart';

/// ===============================================================
/// Era Application Shell
///
/// Root desktop workspace.
///
/// Every feature is hosted inside this shell.
///
/// Layout
/// ------
/// ┌─────────────────────────────────────────────┐
/// │ Toolbar                                     │
/// ├──────────────┬──────────────────────┬───────┤
/// │ Sidebar      │ Main Content         │ Panel │
/// ├──────────────┴──────────────────────┴───────┤
/// │ Status Bar                                  │
/// └─────────────────────────────────────────────┘
///
/// Future
/// ------
/// • Multi-workspace
/// • Plugin regions
/// • Command palette
/// • Notifications
/// • Dock panels
/// • Drag & Drop
/// • Multiple windows
/// ===============================================================
class AppShell extends EraWidget {
  const AppShell({
    super.key,
    required this.content,
    this.toolbar,
    this.sidebar,
    this.rightPanel,
    this.statusBar,
  });

  final Widget content;

  final Widget? toolbar;

  final Widget? sidebar;

  final Widget? rightPanel;

  final Widget? statusBar;

  @override
  Widget buildEra(
    BuildContext context,
    EraWidgetContext design,
  ) {
    return Scaffold(
      backgroundColor: design.colors.background,
      body: SafeArea(
        child: Column(
          children: [
            if (toolbar != null)
              toolbar!,

            Expanded(
              child: Row(
                children: [
                  if (sidebar != null)
                    sidebar!,

                  Expanded(
                    child: content,
                  ),

                  if (rightPanel != null)
                    rightPanel!,
                ],
              ),
            ),

            if (statusBar != null)
              statusBar!,
          ],
        ),
      ),
    );
  }
}