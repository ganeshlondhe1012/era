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

  static const double _maxMessageWidth = 900;

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: Consumer<ChatController>(
        builder: (context, controller, _) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _scroll.scrollToBottom();
          });

          if (!controller.hasMessages) {
            return Container(
              color: theme.colorScheme.surface,
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(32),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 700,
                    ),
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.all(40),
                        child: Column(
                          mainAxisSize:
                              MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              radius: 42,
                              backgroundColor:
                                  theme.colorScheme
                                      .primaryContainer,
                              child: Icon(
                                Icons
                                    .psychology_alt_rounded,
                                size: 42,
                                color: theme
                                    .colorScheme
                                    .primary,
                              ),
                            ),

                            const SizedBox(
                              height: 28,
                            ),

                            Text(
                              'Welcome to Era',
                              style: theme
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                            ),

                            const SizedBox(
                              height: 12,
                            ),

                            Text(
                              'Private Offline AI Assistant',
                              textAlign:
                                  TextAlign.center,
                              style: theme
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: theme
                                        .colorScheme
                                        .primary,
                                  ),
                            ),

                            const SizedBox(
                              height: 32,
                            ),

                            const _WelcomeItem(
                              icon:
                                  Icons.chat_bubble_outline,
                              text:
                                  'Ask questions naturally',
                            ),

                            const SizedBox(
                              height: 18,
                            ),

                            const _WelcomeItem(
                              icon:
                                  Icons.upload_file_outlined,
                              text:
                                  'Upload PDF, DOCX or TXT files',
                            ),

                            const SizedBox(
                              height: 18,
                            ),

                            const _WelcomeItem(
                              icon:
                                  Icons.lock_outline,
                              text:
                                  'Everything stays on your device',
                            ),

                            const SizedBox(
                              height: 32,
                            ),

                            Text(
                              'Start a conversation using the prompt box below.',
                              textAlign:
                                  TextAlign.center,
                              style: theme
                                  .textTheme
                                  .bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }

          return Container(
            color: theme.colorScheme.surface,
            child: ListView.builder(
              controller:
                  _scroll.scrollController,
              padding:
                  const EdgeInsets.fromLTRB(
                24,
                24,
                24,
                120,
              ),
              itemCount:
                  controller.messages.length,
              itemBuilder:
                  (context, index) {
                return Align(
                  alignment:
                      Alignment.topCenter,
                  child: ConstrainedBox(
                    constraints:
                        const BoxConstraints(
                      maxWidth:
                          _maxMessageWidth,
                    ),
                    child: MessageBubble(
                      message: controller
                          .messages[index],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

 class _WelcomeItem extends StatelessWidget {
  const _WelcomeItem({
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 22,
          color: theme.colorScheme.primary,
        ),
        const SizedBox(width: 14),
        Flexible(
          child: Text(
            text,
            style: theme.textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }
}