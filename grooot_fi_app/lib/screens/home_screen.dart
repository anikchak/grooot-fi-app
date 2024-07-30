import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grooot_fi_app/screens/post_screen.dart';
import 'package:grooot_fi_app/screens/profile_screen.dart';
import 'package:grooot_fi_app/screens/scribble_screen.dart';

import 'reel_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentBottomNavPageIndex = 0;
  final List<Widget> _pages = [
    const ReelScreen(),
    const ScribbleScreen(),
    const PostScreen(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentBottomNavPageIndex,
        children: _pages,
      ),
      bottomNavigationBar: NavigationBar(
        indicatorColor: Colors.black,
        selectedIndex: currentBottomNavPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentBottomNavPageIndex = index;
          });
          print("currentPageIndex: $currentBottomNavPageIndex");
        },
        destinations: <Widget>[
          NavigationDestination(
            selectedIcon: SvgPicture.asset('images/home_solid.svg'),
            icon: SvgPicture.asset('images/home_outline.svg'),
            label: 'Home',
          ),
          NavigationDestination(
            icon: SvgPicture.asset('images/msg_outline.svg'),
            selectedIcon: SvgPicture.asset('images/msg_solid.svg'),
            label: 'Scribble',
          ),
          NavigationDestination(
            icon: SvgPicture.asset('images/post_outline.svg'),
            selectedIcon: SvgPicture.asset('images/post_solid.svg'),
            label: 'Post',
          ),
          NavigationDestination(
            icon: SvgPicture.asset('images/profile_outline.svg'),
            selectedIcon: SvgPicture.asset('images/profile_solid.svg'),
            label: 'Me',
          ),
        ],
      ),
    );
  }
}
