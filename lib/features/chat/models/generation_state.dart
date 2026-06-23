enum GenerationState {
  idle,
  generating,
  cancelled,
  completed,
  error,
}

extension GenerationStateX on GenerationState {
  bool get isGenerating => this == GenerationState.generating;

  bool get canSend => this != GenerationState.generating;

  bool get canStop => this == GenerationState.generating;
}