import 'package:flutter/foundation.dart';

@immutable
class NavigationAction {
  const NavigationAction({
    required this.id,
    required this.label,
    required this.icon,
    this.tooltip,
    this.enabled = true,
    this.danger = false,
  });

  final String id;
  final String label;

  /// Material icon codePoint
  final int icon;

  final String? tooltip;

  final bool enabled;

  final bool danger;

  NavigationAction copyWith({
    String? id,
    String? label,
    int? icon,
    String? tooltip,
    bool? enabled,
    bool? danger,
  }) {
    return NavigationAction(
      id: id ?? this.id,
      label: label ?? this.label,
      icon: icon ?? this.icon,
      tooltip: tooltip ?? this.tooltip,
      enabled: enabled ?? this.enabled,
      danger: danger ?? this.danger,
    );
  }
}