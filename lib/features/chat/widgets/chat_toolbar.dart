import 'package:flutter/material.dart';

import '../../../core/design/patterns/toolbar/era_toolbar.dart';
import '../../../core/design/widgets/era_button.dart';

/// ===============================================================
/// Chat Toolbar
///
/// Top toolbar for the chat workspace.
///
/// Future
/// ------
/// • Model Selector
/// • Conversation Title
/// • Memory Status
/// • Token Usage
/// • Regenerate
/// • Export
/// • Share
/// • Voice Mode
/// • Search
/// ===============================================================
class ChatToolbar extends StatelessWidget {
  const ChatToolbar({
    super.key,
    required this.title,
    this.subtitle,
    this.onNewChat,
    this.onClearChat,
    this.onSettings,
    this.trailing = const [],
  });

  final String title;

  final String? subtitle;

  final VoidCallback? onNewChat;

  final VoidCallback? onClearChat;

  final VoidCallback? onSettings;

  final List<Widget> trailing;

  @override
  Widget build(BuildContext context) {
    return EraToolbar(
      title: Text(title),
      subtitle:
          subtitle != null ? Text(subtitle!) : null,
      actions: [
        EraButton(
          label: 'New Chat',
          variant: EraButtonVariant.secondary,
          onPressed: onNewChat,
        ),

        const SizedBox(width: 8),

        EraButton(
          label: 'Clear',
          variant: EraButtonVariant.ghost,
          onPressed: onClearChat,
        ),

        const Spacer(),

        ...trailing,

        if (onSettings != null) ...[
          const SizedBox(width: 8),
          IconButton(
            tooltip: 'Settings',
            icon: const Icon(Icons.settings_outlined),
            onPressed: onSettings,
          ),
        ],
      ],
    );
  }
}