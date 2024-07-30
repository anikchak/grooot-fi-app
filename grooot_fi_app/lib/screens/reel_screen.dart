import 'package:flutter/material.dart';

class ReelScreen extends StatefulWidget {
  const ReelScreen({super.key});

  @override
  State<ReelScreen> createState() => _ReelScreenState();
}

class _ReelScreenState extends State<ReelScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reel feed Page'),
      ),
      body: Center(
        child: Text('Reel feed Page Content'),
      ),
    );
  }
}
