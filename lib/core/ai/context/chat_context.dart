import 'context_store.dart';
import 'context_key.dart';
class ChatContext {
  const ChatContext({
    this.store = const ContextStore(),
  });
  
 final ContextStore store;

  T? read<T>(ContextKey<T> key) {
    return store.read(key);
  }

  ChatContext write<T>(
    ContextKey<T> key,
    T value,
  ) {
    return ChatContext(
      store: store.write(
        key,
        value,
      ),
    );
  }
}