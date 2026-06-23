import 'package:file_picker/file_picker.dart';

class FilePickerService {
  const FilePickerService();

  Future<String?> pickDocument() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: const [
        'txt',
        'md',
        'markdown',
      ],
    );

    if (result == null) {
      return null;
    }

    if (result.files.isEmpty) {
      return null;
    }

    return result.files.single.path;
  }

  Future<List<String>> pickDocuments() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: const [
        'txt',
        'md',
        'markdown',
      ],
    );

    if (result == null) {
      return [];
    }

    return result.files
        .map((e) => e.path)
        .whereType<String>()
        .toList();
  }
}