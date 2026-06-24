import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../theme/theme_controller.dart';
import '../theme/theme_profile.dart';
import '../tokens/color_tokens.dart';
import '../tokens/radius_tokens.dart';
import '../tokens/spacing_tokens.dart';

/// ===============================================================
/// Era BuildContext Extensions
///
/// Widgets NEVER import design tokens directly.
///
/// Instead use:
///
/// context.colors
/// context.spacing
/// context.radius
/// context.themeProfile
/// context.themeController
///
/// Future:
/// context.typography
/// context.motion
/// context.icons
/// context.elevation
/// ===============================================================

extension EraThemeContext on BuildContext {
  ThemeController get themeController =>
      read<ThemeController>();

  ThemeProfile get themeProfile =>
      watch<ThemeController>().profile;

  ColorTokens get colors =>
      themeProfile.colors;

  SpacingTokens get spacing =>
      themeProfile.spacing;

  RadiusTokens get radius =>
      themeProfile.radius;
}