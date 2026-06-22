import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../features/chat/controllers/chat_controller.dart';
import '../features/chat/screens/home_screen.dart';

class EraApp extends StatelessWidget {
  const EraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChatController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Era',
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.dark,
          ),
          scaffoldBackgroundColor: const Color(0xFF121212),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}