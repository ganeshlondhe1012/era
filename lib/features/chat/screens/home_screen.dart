import 'package:flutter/material.dart';

import '../widgets/chat_area.dart';
import '../widgets/prompt_input.dart';
import '../widgets/sidebar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const double _sidebarWidth = 280;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Row(
          children: [
            const SizedBox(width: _sidebarWidth, child: Sidebar()),

            VerticalDivider(width: 1, thickness: 1, color: theme.dividerColor),

            Expanded(
              child: Container(
                color: theme.colorScheme.surfaceContainerLowest,
                child: const Column(
                  children: [
                    Expanded(child: ChatArea()),

                    Divider(height: 1),

                    PromptInput(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
