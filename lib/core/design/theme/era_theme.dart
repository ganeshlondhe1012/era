import 'package:flutter/foundation.dart';

import '../tokens/color_tokens.dart';
import '../tokens/radius_tokens.dart';
import '../tokens/spacing_tokens.dart';

/// ===============================================================
/// Era Design Theme
///
/// This is the root design object used throughout Era.
///
/// Widgets must never access tokens directly.
/// Instead they receive an EraTheme instance.
///
/// Future:
/// - Theme Profiles
/// - User Themes
/// - Plugin Themes
/// - Dynamic Accent Colors
/// - Compact / Comfortable Density
/// - Accessibility Scaling
/// ===============================================================

@immutable
class EraTheme {
  const EraTheme({
    required this.colors,
    required this.spacing,
    required this.radius,
  });

  final ColorTokens colors;

  final SpacingTokens spacing;

  final RadiusTokens radius;

  static const dark = EraTheme(
    colors: ColorTokens.dark,
    spacing: SpacingTokens.desktop,
    radius: RadiusTokens.desktop,
  );

  EraTheme copyWith({
    ColorTokens? colors,
    SpacingTokens? spacing,
    RadiusTokens? radius,
  }) {
    return EraTheme(
      colors: colors ?? this.colors,
      spacing: spacing ?? this.spacing,
      radius: radius ?? this.radius,
    );
  }
}