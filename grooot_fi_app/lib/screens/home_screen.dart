import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grooot_fi_app/screens/post_screen_landing.dart';
import 'package:grooot_fi_app/screens/profile_screen.dart';
import 'package:grooot_fi_app/screens/reel_screen.dart';
import 'package:grooot_fi_app/screens/scribble_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentSelectedIndex = 0;
  bool isBottomNavBarVisible = true;
  final GlobalKey<NavigatorState> reelNav = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> scribbleNav = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> postNav = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> profileNav = GlobalKey<NavigatorState>();

  void _toggleBottomNavBarVisibility(bool isVisible) {
    print("_toggleBottomNavBarVisibility called: $isVisible");
    setState(() {
      isBottomNavBarVisible = isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        currentIndex: currentSelectedIndex,
        activeColor: const Color(0xFFCDEB3F),
        inactiveColor: const Color(0xFFCDEB3F),
        onTap: (index) {
          postNav.currentState!.popUntil((r) => r.isFirst);
          // scribbleNav.currentState!.popUntil((r) => r.isFirst);
          // reelNav.currentState!.popUntil((r) => r.isFirst);
          // profileNav.currentState!.popUntil((r) => r.isFirst);
          currentSelectedIndex = index;
        },
        backgroundColor: Theme.of(context).primaryColor,
        height: isBottomNavBarVisible ? 60 : 0,
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              size: 35,
            ),
            activeIcon: Icon(
              Icons.home_rounded,
              size: 35,
            ),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.chat_outlined,
              size: 32,
            ),
            activeIcon: Icon(
              Icons.chat_rounded,
              size: 32,
            ),
            label: 'Scribble',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.add_circle_outline_rounded,
              size: 35,
            ),
            activeIcon: Icon(
              Icons.add_circle_rounded,
              size: 35,
            ),
            label: 'Post',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'images/profile_outline.svg',
              height: 25,
            ),
            activeIcon: SvgPicture.asset(
              'images/profile_solid.svg',
              height: 25,
            ),
            label: 'Me',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              navigatorKey: reelNav,
              builder: (context) {
                return const CupertinoPageScaffold(child: ReelScreen());
              },
            );
          case 1:
            return CupertinoTabView(
              navigatorKey: scribbleNav,
              builder: (context) {
                return const CupertinoPageScaffold(child: ScribbleScreen());
              },
            );
          case 2:
            return CupertinoTabView(
              navigatorKey: postNav,
              builder: (context) {
                return CupertinoPageScaffold(
                  child: PostScreen(
                    toggleBottomNavBarVisibility: _toggleBottomNavBarVisibility,
                  ),
                );
              },
            );
          case 3:
            return CupertinoTabView(
              navigatorKey: profileNav,
              builder: (context) {
                return const CupertinoPageScaffold(child: ProfileScreen());
              },
            );
          default:
            return CupertinoTabView(
              builder: (context) {
                return const CupertinoPageScaffold(child: ReelScreen());
              },
            );
        }
      },
    );
  }
}
