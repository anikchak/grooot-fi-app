import 'package:flutter/material.dart';

class ScribbleScreen extends StatefulWidget {
  const ScribbleScreen({super.key});

  @override
  State<ScribbleScreen> createState() => _ScribbleScreenState();
}

class _ScribbleScreenState extends State<ScribbleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scribble Page'),
      ),
      body: Center(
        child: Text('Scribble Page Content'),
      ),
    );
  }
}
