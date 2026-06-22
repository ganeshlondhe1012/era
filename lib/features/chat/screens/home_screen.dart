import 'package:flutter/material.dart';

import '../widgets/chat_area.dart';
import '../widgets/prompt_input.dart';
import '../widgets/sidebar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            // Left Sidebar
            const Sidebar(),

            // Right Content
            Expanded(
              child: Column(
                children: const [
                  ChatArea(),
                  PromptInput(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}