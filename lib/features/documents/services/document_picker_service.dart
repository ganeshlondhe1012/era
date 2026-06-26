import 'package:file_picker/file_picker.dart';

class DocumentPickerService {
  const DocumentPickerService();

  Future<PlatformFile?> pickDocument() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      withData: false,
      type: FileType.custom,
      allowedExtensions: const [
        'pdf',
        'txt',
        'md',
        'docx',
      ],
    );

    if (result == null || result.files.isEmpty) {
      return null;
    }

    return result.files.first;
  }
}