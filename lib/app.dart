import 'package:a1_workspace/features/login/presentation/pages/login_page.dart';
import 'package:a1_workspace/shared/theme/theme.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: const LoginPage(),
    );
  }
}
