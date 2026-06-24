import 'package:flutter/foundation.dart';

import '../models/navigation_destination.dart';

/// ===============================================================
/// Era Navigation Controller
///
/// Owns application navigation state.
///
/// Responsibilities
/// ----------------
/// • Current destination
/// • Available destinations
/// • Navigation history (future)
/// • Deep linking (future)
/// • Workspace routing (future)
/// ===============================================================
class NavigationController extends ChangeNotifier {
  NavigationController({
    required List<NavigationDestination> destinations,
    String? initialDestinationId,
  }) : _destinations = List.unmodifiable(destinations) {
    assert(_destinations.isNotEmpty);

    _selectedId = initialDestinationId ??
        _destinations.first.id;
  }

  final List<NavigationDestination> _destinations;

  late String _selectedId;

  List<NavigationDestination> get destinations =>
      _destinations;

  String get selectedId => _selectedId;

  NavigationDestination get currentDestination =>
      _destinations.firstWhere(
        (d) => d.id == _selectedId,
      );

  bool isSelected(String id) {
    return _selectedId == id;
  }

  void navigateTo(String id) {
    if (_selectedId == id) {
      return;
    }

    final exists = _destinations.any(
      (d) => d.id == id,
    );

    if (!exists) {
      return;
    }

    _selectedId = id;

    notifyListeners();
  }

  NavigationDestination? destinationById(
    String id,
  ) {
    try {
      return _destinations.firstWhere(
        (d) => d.id == id,
      );
    } catch (_) {
      return null;
    }
  }
}