import 'package:flutter/material.dart';

import '../extensions/theme_extensions.dart';
import '../theme/theme_profile.dart';
import '../tokens/color_tokens.dart';
import '../tokens/radius_tokens.dart';
import '../tokens/spacing_tokens.dart';

/// ===============================================================
/// Era Widget Base
///
/// Every reusable design widget should extend EraWidget
/// instead of StatelessWidget.
///
/// Benefits:
/// • Centralized access to design tokens
/// • Future localization access
/// • Future animation tokens
/// • Future typography tokens
/// • Future accessibility
/// • Future plugin context
/// ===============================================================
abstract class EraWidget extends StatelessWidget {
  const EraWidget({super.key});

  @protected
  Widget buildEra(
    BuildContext context,
    EraWidgetContext design,
  );

  @override
  Widget build(BuildContext context) {
    return buildEra(
      context,
      EraWidgetContext.fromContext(context),
    );
  }
}

@immutable
class EraWidgetContext {
  const EraWidgetContext({
    required this.theme,
    required this.colors,
    required this.spacing,
    required this.radius,
  });

  final ThemeProfile theme;

  final ColorTokens colors;

  final SpacingTokens spacing;

  final RadiusTokens radius;

  factory EraWidgetContext.fromContext(
    BuildContext context,
  ) {
    final profile = context.themeProfile;

    return EraWidgetContext(
      theme: profile,
      colors: profile.colors,
      spacing: profile.spacing,
      radius: profile.radius,
    );
  }
}