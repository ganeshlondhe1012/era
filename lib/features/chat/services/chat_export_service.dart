import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../models/chat.dart';

class ChatExportService {
  const ChatExportService();

  Future<File> exportMarkdown(Chat chat) async {
    final directory = await getApplicationDocumentsDirectory();

    final safeTitle = chat.title
        .replaceAll(RegExp(r'[\\/:*?"<>|]'), '_')
        .trim();

    final file = File(
      '${directory.path}/$safeTitle.md',
    );

    final buffer = StringBuffer();

    buffer.writeln('# ${chat.title}');
    buffer.writeln();

    buffer.writeln(
      'Created: ${chat.createdAt}',
    );

    buffer.writeln();

    buffer.writeln('---');
    buffer.writeln();

    for (final message in chat.messages) {
      buffer.writeln(
        message.isUser
            ? '## You'
            : '## Era',
      );

      buffer.writeln();

      buffer.writeln(message.text);

      buffer.writeln();
    }

    await file.writeAsString(
      buffer.toString(),
    );

    return file;
  }
}