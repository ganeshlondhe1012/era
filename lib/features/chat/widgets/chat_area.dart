import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/chat_controller.dart';
import '../controllers/chat_scroll_controller.dart';
import 'message_bubble.dart';

class ChatArea extends StatefulWidget {
  const ChatArea({super.key});

  @override
  State<ChatArea> createState() => _ChatAreaState();
}

class _ChatAreaState extends State<ChatArea> {
  final ChatScrollController _scroll =
      ChatScrollController();

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<ChatController>(
        builder: (context, controller, child) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _scroll.scrollToBottom();
          });

          if (!controller.hasMessages) {
            return Container(
              color: const Color(0xFF121212),
              child: const Center(
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.smart_toy_outlined,
                      size: 72,
                      color: Colors.blueAccent,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Welcome to Era',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Your Offline AI Assistant',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Start a new conversation using the message box below.',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return Container(
            color: const Color(0xFF121212),
            child: ListView.builder(
              controller:
                  _scroll.scrollController,
              padding:
                  const EdgeInsets.symmetric(
                vertical: 20,
              ),
              itemCount:
                  controller.messages.length,
              itemBuilder: (context, index) {
                return MessageBubble(
                  message:
                      controller.messages[index],
                );
              },
            ),
          );
        },
      ),
    );
  }
}