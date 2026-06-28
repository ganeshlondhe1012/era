import '../pipeline/context_provider.dart';

class AiRegistry {
  AiRegistry._();

  static final List<ContextProvider> _providers = [];

  static void register(
    ContextProvider provider,
  ) {
    _providers.add(provider);
  }

  static List<ContextProvider> get providers =>
      List.unmodifiable(_providers);
}