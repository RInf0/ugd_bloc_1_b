import 'package:flutter/material.dart';
import 'package:ugd_bloc_1_b/page/login_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: LoginView(),
      ),
    );
  }
}
