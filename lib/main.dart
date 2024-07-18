import 'package:blog_app/core/theme/theme.dart';
import 'package:blog_app/features/authentication/presentation/screens/login_screen.dart';
import 'package:blog_app/features/authentication/presentation/screens/signup_screen.dart';
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
      theme: AppTheme.darkThemeMode,
      home: const LoginScreen(),
    );
  }
}
