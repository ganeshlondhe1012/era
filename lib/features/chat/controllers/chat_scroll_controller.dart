import 'package:flutter/widgets.dart';

class ChatScrollController {
  final ScrollController scrollController =
      ScrollController();

  void scrollToBottom({
    bool animated = true,
  }) {
    if (!scrollController.hasClients) {
      return;
    }

    final position =
        scrollController.position.maxScrollExtent;

    if (animated) {
      scrollController.animateTo(
        position,
        duration: const Duration(
          milliseconds: 250,
        ),
        curve: Curves.easeOut,
      );
    } else {
      scrollController.jumpTo(position);
    }
  }

  void dispose() {
    scrollController.dispose();
  }
}