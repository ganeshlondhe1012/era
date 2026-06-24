import 'package:flutter/foundation.dart';

/// ===============================================================
/// Era Navigation Destination
///
/// Represents a destination in the application.
///
/// Examples:
/// • Chats
/// • Documents
/// • Memory
/// • Agents
/// • Plugins
/// • Settings
///
/// This model contains no UI logic.
/// ===============================================================

@immutable
class NavigationDestination {
  const NavigationDestination({
    required this.id,
    required this.title,
    required this.icon,
    this.selectedIcon,
    this.tooltip,
    this.badgeCount,
    this.enabled = true,
  });

  /// Unique identifier.
  final String id;

  /// Display title.
  final String title;

  /// Material icon code point.
  ///
  /// Stored as an int instead of IconData so the model
  /// remains UI-independent and easier to serialize.
  final int icon;

  /// Optional selected icon.
  final int? selectedIcon;

  /// Tooltip shown on hover.
  final String? tooltip;

  /// Optional badge.
  final int? badgeCount;

  /// Whether the destination is enabled.
  final bool enabled;

  NavigationDestination copyWith({
    String? id,
    String? title,
    int? icon,
    int? selectedIcon,
    String? tooltip,
    int? badgeCount,
    bool? enabled,
  }) {
    return NavigationDestination(
      id: id ?? this.id,
      title: title ?? this.title,
      icon: icon ?? this.icon,
      selectedIcon: selectedIcon ?? this.selectedIcon,
      tooltip: tooltip ?? this.tooltip,
      badgeCount: badgeCount ?? this.badgeCount,
      enabled: enabled ?? this.enabled,
    );
  }
}