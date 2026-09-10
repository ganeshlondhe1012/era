import 'context_key.dart';

class ContextStore {
  const ContextStore({Map<ContextKey<Object?>, Object?>? values})
    : _values = values ?? const {};

  final Map<ContextKey<Object?>, Object?> _values;

  T? read<T>(ContextKey<T> key) {
    final value = _values[key as ContextKey<Object?>];

    if (value is T) {
      return value;
    }

    return null;
  }

  ContextStore write<T>(ContextKey<T> key, T value) {
    return ContextStore(
      values: {..._values, key as ContextKey<Object?>: value},
    );
  }

  bool contains<T>(ContextKey<T> key) {
    return _values.containsKey(key as ContextKey<Object?>);
  }

  Iterable<ContextKey<Object?>> get keys => _values.keys;
}
