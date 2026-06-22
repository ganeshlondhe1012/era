import 'package:flutter/material.dart';

import '../features/chat/screens/home_screen.dart';

class EraApp extends StatelessWidget {
  const EraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Era',
      debugShowCheckedModeBanner: false,

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
    );
  }
}