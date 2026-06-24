import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// ===============================================================
/// Era Design System
/// Semantic Color Tokens
///
/// Rules:
/// - Never use Color(0xFF...)
/// - Never use Colors.blue
/// - Never use Colors.grey
///
/// Widgets consume semantic colors only.
///
/// Future
/// - Light Theme
/// - Dark Theme
/// - AMOLED Theme
/// - Dynamic Accent
/// - User Themes
/// - Plugin Themes
/// ===============================================================

@immutable
class ColorTokens {
  const ColorTokens({
    required this.primary,
    required this.primaryContainer,

    required this.background,
    required this.surface,
    required this.surfaceVariant,

    required this.outline,
    required this.divider,

    required this.textPrimary,
    required this.textSecondary,
    required this.textDisabled,

    required this.chatUserBubble,
    required this.chatAssistantBubble,

    required this.success,
    required this.warning,
    required this.error,
    required this.info,
  });

  final Color primary;
  final Color primaryContainer;

  final Color background;
  final Color surface;
  final Color surfaceVariant;

  final Color outline;
  final Color divider;

  final Color textPrimary;
  final Color textSecondary;
  final Color textDisabled;

  final Color chatUserBubble;
  final Color chatAssistantBubble;

  final Color success;
  final Color warning;
  final Color error;
  final Color info;

  static const dark = ColorTokens(
    primary: Color(0xFF5E81F4),
    primaryContainer: Color(0xFF4162D8),

    background: Color(0xFF111315),

    surface: Color(0xFF1A1C1F),

    surfaceVariant: Color(0xFF24272C),

    outline: Color(0xFF3C414A),

    divider: Color(0xFF2E3238),

    textPrimary: Color(0xFFFFFFFF),

    textSecondary: Color(0xFFB3BAC5),

    textDisabled: Color(0xFF7D8794),

    chatUserBubble: Color(0xFF4162D8),

    chatAssistantBubble: Color(0xFF24272C),

    success: Color(0xFF34C759),

    warning: Color(0xFFFFB020),

    error: Color(0xFFFF453A),

    info: Color(0xFF4DA3FF),
  );

  ColorTokens copyWith({
    Color? primary,
    Color? primaryContainer,
    Color? background,
    Color? surface,
    Color? surfaceVariant,
    Color? outline,
    Color? divider,
    Color? textPrimary,
    Color? textSecondary,
    Color? textDisabled,
    Color? chatUserBubble,
    Color? chatAssistantBubble,
    Color? success,
    Color? warning,
    Color? error,
    Color? info,
  }) {
    return ColorTokens(
      primary: primary ?? this.primary,
      primaryContainer:
          primaryContainer ?? this.primaryContainer,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceVariant:
          surfaceVariant ?? this.surfaceVariant,
      outline: outline ?? this.outline,
      divider: divider ?? this.divider,
      textPrimary:
          textPrimary ?? this.textPrimary,
      textSecondary:
          textSecondary ?? this.textSecondary,
      textDisabled:
          textDisabled ?? this.textDisabled,
      chatUserBubble:
          chatUserBubble ?? this.chatUserBubble,
      chatAssistantBubble:
          chatAssistantBubble ??
              this.chatAssistantBubble,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      error: error ?? this.error,
      info: info ?? this.info,
    );
  }
}