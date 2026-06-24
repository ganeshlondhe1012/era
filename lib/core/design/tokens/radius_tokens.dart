import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// ===============================================================
/// Era Design System
/// Radius Tokens
///
/// Rules:
/// - Never use BorderRadius.circular() directly.
/// - Never hardcode radius values.
/// - Every widget uses RadiusTokens.
///
/// Future:
/// - Compact Mode
/// - Fluent Design
/// - Material You
/// - Custom Themes
/// ===============================================================

@immutable
class RadiusTokens {
  const RadiusTokens({
    required this.none,
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.xxl,
    required this.full,
  });

  final BorderRadius none;

  final BorderRadius xs;

  final BorderRadius sm;

  final BorderRadius md;

  final BorderRadius lg;

  final BorderRadius xl;

  final BorderRadius xxl;

  final BorderRadius full;

  static BorderRadius _radius(double value) =>
      BorderRadius.circular(value);

  static final desktop = RadiusTokens(
    none: BorderRadius.zero,

    xs: _radius(4),

    sm: _radius(8),

    md: _radius(12),

    lg: _radius(16),

    xl: _radius(24),

    xxl: _radius(32),

    full: BorderRadius.circular(9999),
  );

  RadiusTokens copyWith({
    BorderRadius? none,
    BorderRadius? xs,
    BorderRadius? sm,
    BorderRadius? md,
    BorderRadius? lg,
    BorderRadius? xl,
    BorderRadius? xxl,
    BorderRadius? full,
  }) {
    return RadiusTokens(
      none: none ?? this.none,
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      xxl: xxl ?? this.xxl,
      full: full ?? this.full,
    );
  }
}