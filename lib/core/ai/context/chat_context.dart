class ChatContext {
  const ChatContext({
    this.values = const {},
  });

  final Map<String, Object?> values;

  T? get<T>(String key) {
    final value = values[key];
    if (value is T) {
      return value;
    }
    return null;
  }

  ChatContext copyWithValue(
    String key,
    Object? value,
  ) {
    return ChatContext(
      values: {
        ...values,
        key: value,
      },
    );
  }
}