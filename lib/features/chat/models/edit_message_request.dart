import 'package:flutter/foundation.dart';

@immutable
class EditMessageRequest {
  const EditMessageRequest({
    required this.messageId,
    required this.newText,
  });

  final String messageId;
  final String newText;
}