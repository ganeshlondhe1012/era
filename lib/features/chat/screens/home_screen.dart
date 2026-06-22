import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/chat_controller.dart';
import '../widgets/chat_area.dart';
import '../widgets/prompt_input.dart';
import '../widgets/sidebar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChatController(),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            const Sidebar(),

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