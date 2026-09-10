import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/ai/providers/ollam_provider.dart';
import '../core/theme/app_theme.dart';

import '../features/chat/controllers/chat_controller.dart';
import '../features/chat/screens/home_screen.dart';
import '../features/chat/services/ollama_service.dart';

import '../features/settings/controllers/settings_controller.dart';
import '../features/settings/models/app_settings.dart';

import '../features/ai/controllers/ai_settings_controller.dart';

import '../features/rag/controllers/ask_documents_controller.dart';
import '../features/rag/controllers/document_controller.dart';
import '../features/rag/repository/local_document_repository.dart';
import '../features/rag/services/document_service.dart';
import '../features/rag/services/document_import_workflow.dart';
import '../features/rag/services/file_picker_service.dart';
import '../features/rag/services/import_document_service.dart';
import '../features/rag/services/python_rag_client.dart';
import '../features/rag/services/rag_pipeline.dart';

class EraApp extends StatelessWidget {
  const EraApp({super.key});

  static const String embeddingModel = 'nomic-embed-text';

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SettingsController>(
          create: (_) {
            final controller = SettingsController();
            controller.initialize();
            return controller;
          },
        ),
        ChangeNotifierProvider<AISettingsController>(
          create: (_) {
            final controller = AISettingsController();
            controller.initialize();
            return controller;
          },
        ),
        Provider<OllamaService>(create: (_) => OllamaService()),
        Provider<PythonRagClient>(
          create: (_) => PythonRagClient(),
          dispose: (_, client) => client.dispose(),
        ),
        Provider<DocumentService>(
          create: (_) => DocumentService(repository: LocalDocumentRepository()),
        ),
        Provider<RagPipeline>(
          create: (context) {
            final pipeline = RagPipeline(
              documentService: context.read<DocumentService>(),
              client: context.read<PythonRagClient>(),
            );
            pipeline.initialize(embeddingModel: embeddingModel);
            return pipeline;
          },
        ),
        Provider<ImportDocumentService>(
          create: (context) => ImportDocumentService(
            pipeline: context.read<RagPipeline>(),
          ),
        ),
        Provider<DocumentImportWorkflow>(
          create: (context) => DocumentImportWorkflow(
            filePickerService: const FilePickerService(),
            importService: context.read<ImportDocumentService>(),
          ),
        ),
        ChangeNotifierProvider<DocumentController>(
          create: (context) {
            final controller = DocumentController(
              documentService: context.read<DocumentService>(),
              workflow: context.read<DocumentImportWorkflow>(),
              ragPipeline: context.read<RagPipeline>(),
            );
            controller.initialize();
            return controller;
          },
        ),
        ChangeNotifierProvider<AskDocumentsController>(
          create: (context) => AskDocumentsController(
            ragPipeline: context.read<RagPipeline>(),
          ),
        ),
        ChangeNotifierProvider<ChatController>(
          create: (context) => ChatController(
            provider: OllamaProvider(service: context.read<OllamaService>()),
          ),
        ),
      ],
      child: Consumer<SettingsController>(
        builder: (context, settings, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Era',
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            themeMode: _toFlutterThemeMode(settings.themeMode),
            home: const HomeScreen(),
          );
        },
      ),
    );
  }

  ThemeMode _toFlutterThemeMode(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.system:
        return ThemeMode.system;
      case AppThemeMode.light:
        return ThemeMode.light;
      default:
        return ThemeMode.dark;
    }
  }
}
