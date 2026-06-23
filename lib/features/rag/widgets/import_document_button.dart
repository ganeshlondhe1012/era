import 'package:flutter/material.dart';

import '../services/document_import_workflow.dart';

class ImportDocumentButton extends StatefulWidget {
  const ImportDocumentButton({
    super.key,
    required this.workflow,
    this.onImported,
  });

  final DocumentImportWorkflow workflow;

  final VoidCallback? onImported;

  @override
  State<ImportDocumentButton> createState() =>
      _ImportDocumentButtonState();
}

class _ImportDocumentButtonState
    extends State<ImportDocumentButton> {
  bool _isImporting = false;

  Future<void> _import() async {
    if (_isImporting) {
      return;
    }

    setState(() {
      _isImporting = true;
    });

    try {
      final document =
          await widget.workflow.importSingle();

      if (!mounted) {
        return;
      }

      if (document != null) {
        widget.onImported?.call();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${document.name} imported successfully.',
            ),
          ),
        );
      }
    } catch (e) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Import failed: $e',
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isImporting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: _isImporting
          ? null
          : _import,
      icon: _isImporting
          ? const SizedBox(
              width: 18,
              height: 18,
              child:
                  CircularProgressIndicator(
                strokeWidth: 2,
              ),
            )
          : const Icon(
              Icons.upload_file,
            ),
      label: Text(
        _isImporting
            ? 'Importing...'
            : 'Import Document',
      ),
    );
  }
}