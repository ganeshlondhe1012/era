class DocumentAttachment {
  const DocumentAttachment({
    required this.id,
    required this.name,
    required this.path,
    required this.mimeType,
    required this.uploadedAt,
    required this.text,
  });

  final String id;

  /// Display name
  final String name;

  /// Absolute file path
  final String path;

  /// application/pdf, text/plain...
  final String mimeType;

  /// Extracted text
  final String text;

  final DateTime uploadedAt;

  bool get hasContent => text.trim().isNotEmpty;

  int get characterCount => text.length;

  int get estimatedTokens => (text.length / 4).ceil();

  DocumentAttachment copyWith({
    String? id,
    String? name,
    String? path,
    String? mimeType,
    String? text,
    DateTime? uploadedAt,
  }) {
    return DocumentAttachment(
      id: id ?? this.id,
      name: name ?? this.name,
      path: path ?? this.path,
      mimeType: mimeType ?? this.mimeType,
      text: text ?? this.text,
      uploadedAt: uploadedAt ?? this.uploadedAt,
    );
  }
}
