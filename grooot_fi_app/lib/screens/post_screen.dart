import 'package:flutter/material.dart';

import '../components/custom_bottom_navigation.dart';
import '../utility/BottomNavBarNavigationUtility.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Page'),
      ),
      body: Center(
        child: Text('Post Page Content'),
      ),
    );
  }
}
