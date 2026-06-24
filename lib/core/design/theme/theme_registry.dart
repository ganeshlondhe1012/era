import 'package:flutter/foundation.dart';

import '../tokens/color_tokens.dart';
import '../tokens/radius_tokens.dart';
import '../tokens/spacing_tokens.dart';
import 'theme_profile.dart';

/// ===============================================================
/// Era Theme Registry
///
/// Central registry of every available theme.
///
/// Widgets never create themes.
///
/// Future:
/// - Plugin themes
/// - Downloadable themes
/// - User themes
/// - Import/Export themes
/// ===============================================================

@immutable
class ThemeRegistry {
  const ThemeRegistry._();

  static final ThemeProfile eraDark = ThemeProfile(
    id: 'era_dark',
    displayName: 'Era Dark',
    isDark: true,
    isEditable: false,
    colors: ColorTokens.dark,
    spacing: SpacingTokens.desktop,
    radius: RadiusTokens.desktop,
  );

  /// Every built-in theme lives here.
  static final List<ThemeProfile> builtInThemes = [
    eraDark,
  ];

  static ThemeProfile defaultTheme() {
    return eraDark;
  }

  static ThemeProfile? byId(String id) {
    try {
      return builtInThemes.firstWhere(
        (theme) => theme.id == id,
      );
    } catch (_) {
      return null;
    }
  }

  static bool exists(String id) {
    return builtInThemes.any(
      (theme) => theme.id == id,
    );
  }
}