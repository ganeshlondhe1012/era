import 'package:flutter/material.dart';

/// ===============================================================
/// Era Design System
/// Spacing Tokens
///
/// Rules:
/// - Never hardcode spacing in widgets.
/// - Always consume these tokens.
/// - Widgets should depend on SpacingTokens only.
///
/// Future:
/// - User configurable UI density
/// - Tablet/Desktop scaling
/// - Accessibility scaling
/// ===============================================================

@immutable
class SpacingTokens {
  const SpacingTokens({
    required this.xxxs,
    required this.xxs,
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.xxl,
    required this.xxxl,
    required this.pagePadding,
    required this.sectionSpacing,
    required this.cardPadding,
    required this.chatBubblePadding,
    required this.sidebarPadding,
    required this.inputPadding,
  });

  final double xxxs;
  final double xxs;
  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double xxl;
  final double xxxl;

  final EdgeInsets pagePadding;

  final EdgeInsets sectionSpacing;

  final EdgeInsets cardPadding;

  final EdgeInsets chatBubblePadding;

  final EdgeInsets sidebarPadding;

  final EdgeInsets inputPadding;

  static const desktop = SpacingTokens(
    xxxs: 2,
    xxs: 4,
    xs: 8,
    sm: 12,
    md: 16,
    lg: 20,
    xl: 24,
    xxl: 32,
    xxxl: 48,

    pagePadding: EdgeInsets.all(24),

    sectionSpacing: EdgeInsets.symmetric(
      horizontal: 24,
      vertical: 20,
    ),

    cardPadding: EdgeInsets.all(20),

    chatBubblePadding: EdgeInsets.symmetric(
      horizontal: 18,
      vertical: 14,
    ),

    sidebarPadding: EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 18,
    ),

    inputPadding: EdgeInsets.symmetric(
      horizontal: 18,
      vertical: 14,
    ),
  );

  SpacingTokens copyWith({
    double? xxxs,
    double? xxs,
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? xxl,
    double? xxxl,
    EdgeInsets? pagePadding,
    EdgeInsets? sectionSpacing,
    EdgeInsets? cardPadding,
    EdgeInsets? chatBubblePadding,
    EdgeInsets? sidebarPadding,
    EdgeInsets? inputPadding,
  }) {
    return SpacingTokens(
      xxxs: xxxs ?? this.xxxs,
      xxs: xxs ?? this.xxs,
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      xxl: xxl ?? this.xxl,
      xxxl: xxxl ?? this.xxxl,
      pagePadding: pagePadding ?? this.pagePadding,
      sectionSpacing: sectionSpacing ?? this.sectionSpacing,
      cardPadding: cardPadding ?? this.cardPadding,
      chatBubblePadding:
          chatBubblePadding ?? this.chatBubblePadding,
      sidebarPadding:
          sidebarPadding ?? this.sidebarPadding,
      inputPadding:
          inputPadding ?? this.inputPadding,
    );
  }
}