import 'package:flutter/widgets.dart';

class ChatScrollController {
  ChatScrollController() {
    scrollController.addListener(_onScroll);
  }

  final ScrollController scrollController = ScrollController();

  bool _autoScroll = true;

  bool get autoScroll => _autoScroll;

  bool get hasClients => scrollController.hasClients;

  void _onScroll() {
    if (!scrollController.hasClients) {
      return;
    }

    final position = scrollController.position;

    const threshold = 80.0;

    final distance = position.maxScrollExtent - position.pixels;

    _autoScroll = distance <= threshold;
  }

  bool get isNearBottom {
    if (!scrollController.hasClients) {
      return true;
    }

    final position = scrollController.position;

    return (position.maxScrollExtent - position.pixels) < 80;
  }

  void scrollToBottom({bool animated = true, bool force = false}) {
    if (!scrollController.hasClients) {
      return;
    }

    if (!_autoScroll && !force) {
      return;
    }

    final offset = scrollController.position.maxScrollExtent;

    if (animated) {
      scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
      );
    } else {
      scrollController.jumpTo(offset);
    }
  }

  void enableAutoScroll() {
    _autoScroll = true;
  }

  void disableAutoScroll() {
    _autoScroll = false;
  }

  void dispose() {
    scrollController.removeListener(_onScroll);

    scrollController.dispose();
  }
}
