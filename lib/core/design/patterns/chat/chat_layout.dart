import 'package:flutter/material.dart';

import '../../layout/era_split_view.dart';
import '../../widgets/era_widget.dart';

/// ===============================================================
/// Era Chat Layout
///
/// Standard conversation workspace.
///
/// Every conversational feature in Era should
/// use this layout.
///
/// Future:
/// • Multi-chat
/// • Right inspector
/// • Resizable panels
/// • Voice panel
/// • AI status panel
/// • Document references
/// • Agent sidebar
/// ===============================================================
class ChatLayout extends EraWidget {
  const ChatLayout({
    super.key,
    required this.sidebar,
    required this.conversation,
    this.inspector,
  });

  final Widget sidebar;

  final Widget conversation;

  final Widget? inspector;

  @override
  Widget buildEra(
    BuildContext context,
    EraWidgetContext design,
  ) {
    Widget content = EraSplitView(
      primary: sidebar,
      secondary: conversation,
      primaryFlex: 1,
      secondaryFlex: 4,
    );

    if (inspector != null) {
      content = Row(
        children: [
          Expanded(child: content),
          SizedBox(width: design.spacing.md),
          SizedBox(
            width: 320,
            child: inspector,
          ),
        ],
      );
    }

    return content;
  }
}