import 'package:flutter/foundation.dart';

@immutable
class RegenerateRequest {
  const RegenerateRequest({
    required this.prompt,
    required this.model,
  });

  final String prompt;
  final String model;
}