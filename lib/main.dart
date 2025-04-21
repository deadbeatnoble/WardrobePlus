import 'package:WardrobePlus/core/themes/app_theme.dart';
import 'package:WardrobePlus/features/auth/presentation/pages/getting_started.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightThemeMode,
      home: GettingStartedPage(),
    );
  }
}