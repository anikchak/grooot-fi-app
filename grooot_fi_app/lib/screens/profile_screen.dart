import 'package:flutter/material.dart';

import '../components/custom_bottom_navigation.dart';
import '../utility/BottomNavBarNavigationUtility.dart';
import 'home_screen.dart';
import 'scribble_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
      ),
      body: Center(
        child: Text('Profile Page Content'),
      ),
    );
  }
}
