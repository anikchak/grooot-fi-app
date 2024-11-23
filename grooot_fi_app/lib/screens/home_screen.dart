import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grooot_fi_app/screens/post_discussion_screen.dart';
import 'package:grooot_fi_app/screens/profile_screen.dart';
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

  // //Post screen controllers
  // final TextEditingController _postTitleController = TextEditingController();
  // final TextEditingController _postDescriptionController =
  //     TextEditingController();

  // ValueNotifier to manage post title, description, and selected category
  final ValueNotifier<Map<String, dynamic>> postDataNotifier =
      ValueNotifier<Map<String, dynamic>>({
    'postTitle': '',
    'postDescription': '',
    'selectedImageUrl': null,
    'selectedTitle': null,
  });

  @override
  void dispose() {
    // _postTitleController
    //     .dispose(); // Dispose the controller when the widget is disposed
    // _postDescriptionController.dispose();
    postDataNotifier.dispose();
    super.dispose();
  }

  void _toggleBottomNavBarVisibility(bool isVisible) {
    print("_toggleBottomNavBarVisibility called: $isVisible");
    setState(() {
      isBottomNavBarVisible = isVisible;
    });
  }

  void _clearPostFields() {
    postDataNotifier.value = {
      'postTitle': '', // Reset post title
      'postDescription': '', // Reset post description
      'selectedImageUrl': null, // Reset category image
      'selectedTitle': null, // Reset category title
    };
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        currentIndex: currentSelectedIndex,
        activeColor: const Color(0xFFCDEB3F),
        inactiveColor: const Color(0xFFCDEB3F),
        onTap: (index) {
          // Clear the post title controller on tab change (except Post tab)
          if (index != 1) {
            _clearPostFields();
            postNav.currentState?.popUntil((r) => r.isFirst);
            // _postTitleController.clear();
            // _postDescriptionController
            //     .clear(); // Clear text field only when switching away from Post
            // Reset the category selection when switching away from Post tab
            //postNav.currentState?.resetCategorySelection();
          }
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
          // const BottomNavigationBarItem(
          //   icon: Icon(
          //     Icons.chat_outlined,
          //     size: 32,
          //   ),
          //   activeIcon: Icon(
          //     Icons.chat_rounded,
          //     size: 32,
          //   ),
          //   label: 'Scribble',
          // ),
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
          // case 0:
          //   return CupertinoTabView(
          //     navigatorKey: reelNav,
          //     builder: (context) {
          //       return const CupertinoPageScaffold(child: ReelScreen());
          //     },
          //   );
          case 0:
            return CupertinoTabView(
              navigatorKey: scribbleNav,
              builder: (context) {
                return const CupertinoPageScaffold(child: ScribbleScreen());
              },
            );
          case 1:
            return CupertinoTabView(
              navigatorKey: postNav,
              builder: (context) {
                return CupertinoPageScaffold(
                  child: PostDiscussionScreen(
                    // key: postNav,
                    // postTitleController: _postTitleController,
                    // postDescriptionController: _postDescriptionController,
                    postDataNotifier: postDataNotifier,
                    toggleBottomNavBarVisibility: _toggleBottomNavBarVisibility,
                  ),
                );
              },
            );
          case 2:
            return CupertinoTabView(
              navigatorKey: profileNav,
              builder: (context) {
                return const CupertinoPageScaffold(child: ProfileScreen());
              },
            );
          default:
            return CupertinoTabView(
              navigatorKey: scribbleNav,
              builder: (context) {
                return const CupertinoPageScaffold(child: ScribbleScreen());
              },
            );
        }
      },
    );
  }
}
