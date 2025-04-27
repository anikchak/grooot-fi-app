import 'package:flutter/material.dart';
import 'package:grooot_fi_app/screens/login_page.dart';

void main() {
  runApp(const GroootApp());
}

class GroootApp extends StatelessWidget {
  const GroootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: LoginPage(),
    );
  }
}
