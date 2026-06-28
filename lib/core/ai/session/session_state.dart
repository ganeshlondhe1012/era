enum SessionState {
  idle,
  preparing,
  buildingContext,
  composingPrompt,
  generating,
  streaming,
  toolCalling,
  cancelled,
  completed,
  error,
}