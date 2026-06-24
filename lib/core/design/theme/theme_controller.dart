import 'package:flutter/foundation.dart';

import 'theme_profile.dart';

/// ===============================================================
/// Era Theme State
///
/// Immutable representation of the current UI theme.
///
/// This object contains ONLY state.
/// Business logic belongs in ThemeController.
///
/// Future:
/// - Accent color
/// - UI density
/// - Font scaling
/// - High contrast
/// - Accessibility
/// - AMOLED mode
/// ===============================================================

@immutable
class ThemeState {
  const ThemeState({
    required this.profile,
  });

  final ThemeProfile profile;

  ThemeState copyWith({
    ThemeProfile? profile,
  }) {
    return ThemeState(
      profile: profile ?? this.profile,
    );
  }
}