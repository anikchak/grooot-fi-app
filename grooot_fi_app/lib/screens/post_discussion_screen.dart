import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class PostDiscussionScreen extends StatefulWidget {
  const PostDiscussionScreen({super.key});

  @override
  State<PostDiscussionScreen> createState() => _PostDiscussionScreenState();
}

class _PostDiscussionScreenState extends State<PostDiscussionScreen> {
  int currentBottomNavPageIndex = 2;
  @override
  Widget build(BuildContext context) {
    print("build invoked");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create a post',
          style: GoogleFonts.roboto(
            textStyle: const TextStyle(color: Colors.white),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(
            color: Colors.white, // Customize the color of the divider
            height: 1.0,
          ),
        ),
        toolbarHeight: 40,
      ),
      body: Center(
        child: Text('Post Discussion Page'),
      ),
    );
  }
}
