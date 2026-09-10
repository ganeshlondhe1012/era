import 'package:flutter/material.dart';

import '../models/document_attachment.dart';

class DocumentController extends ChangeNotifier {
  DocumentAttachment? _attachment;

  bool _isLoading = false;

  DocumentAttachment? get attachment => _attachment;

  bool get hasAttachment => _attachment != null;

  bool get isLoading => _isLoading;

  Future<void> attach(DocumentAttachment attachment) async {
    _isLoading = true;
    notifyListeners();

    _attachment = attachment;

    _isLoading = false;
    notifyListeners();
  }

  Future<void> remove() async {
    _attachment = null;
    notifyListeners();
  }

  void clear() {
    _attachment = null;
    notifyListeners();
  }
}
