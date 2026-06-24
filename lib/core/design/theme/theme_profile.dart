import 'package:flutter/foundation.dart';

import '../tokens/color_tokens.dart';
import '../tokens/radius_tokens.dart';
import '../tokens/spacing_tokens.dart';

/// ===============================================================
/// Era Theme Profile
///
/// A complete UI profile.
///
/// Every theme in Era is represented by a ThemeProfile.
/// Widgets never know which profile is active.
///
/// Future:
/// - User Themes
/// - Plugin Themes
/// - Downloadable Themes
/// - AMOLED
/// - Glass
/// - Material You
/// ===============================================================

@immutable
class ThemeProfile {
  const ThemeProfile({
    required this.id,
    required this.displayName,
    required this.colors,
    required this.spacing,
    required this.radius,
    this.isDark = true,
    this.isEditable = false,
  });

  /// Unique identifier.
  final String id;

  /// Display name shown in Settings.
  final String displayName;

  /// Semantic colors.
  final ColorTokens colors;

  /// Design spacing.
  final SpacingTokens spacing;

  /// Radius tokens.
  final RadiusTokens radius;

  /// Whether Flutter should use dark mode.
  final bool isDark;

  /// Built-in themes are locked.
  /// User-created themes are editable.
  final bool isEditable;

  ThemeProfile copyWith({
    String? id,
    String? displayName,
    ColorTokens? colors,
    SpacingTokens? spacing,
    RadiusTokens? radius,
    bool? isDark,
    bool? isEditable,
  }) {
    return ThemeProfile(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      colors: colors ?? this.colors,
      spacing: spacing ?? this.spacing,
      radius: radius ?? this.radius,
      isDark: isDark ?? this.isDark,
      isEditable: isEditable ?? this.isEditable,
    );
  }
}