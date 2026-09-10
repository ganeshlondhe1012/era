import 'package:flutter/material.dart';

/// Central spacing system for Era.
/// Use these constants instead of magic numbers.
class AppSpacing {
  const AppSpacing._();

  static const double xs = 4;

  static const double sm = 8;

  static const double md = 12;

  static const double lg = 16;

  static const double xl = 20;

  static const double xxl = 24;

  static const double xxxl = 32;

  static const EdgeInsets page = EdgeInsets.all(xl);

  static const EdgeInsets card = EdgeInsets.all(lg);

  static const EdgeInsets bubble = EdgeInsets.symmetric(
    horizontal: lg,
    vertical: md,
  );

  static const EdgeInsets section = EdgeInsets.symmetric(
    horizontal: xl,
    vertical: lg,
  );

  static const SizedBox gapXS = SizedBox(height: xs);

  static const SizedBox gapSM = SizedBox(height: sm);

  static const SizedBox gapMD = SizedBox(height: md);

  static const SizedBox gapLG = SizedBox(height: lg);

  static const SizedBox gapXL = SizedBox(height: xl);

  static const SizedBox hGapSM = SizedBox(width: sm);

  static const SizedBox hGapMD = SizedBox(width: md);

  static const SizedBox hGapLG = SizedBox(width: lg);

  static const SizedBox hGapXL = SizedBox(width: xl);
}
