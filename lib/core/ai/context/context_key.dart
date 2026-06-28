class ContextKey<T> {
  const ContextKey(this.name);

  final String name;

  @override
  bool operator ==(Object other) =>
      other is ContextKey &&
      other.name == name;

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() => name;
}