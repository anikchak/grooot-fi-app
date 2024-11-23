import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PostScreen extends StatefulWidget {
  final Function(bool) toggleBottomNavBarVisibility;
  const PostScreen({super.key, required this.toggleBottomNavBarVisibility});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create a post',
          style: GoogleFonts.roboto(
            textStyle: const TextStyle(color: Colors.white),
          ),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(
            color: Colors.white, // Customize the color of the divider
            height: 1.0,
          ),
        ),
        toolbarHeight: 50,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            roundedRectBorderWidget(
                'Start a new discussion', 'discussion', context),
            const SizedBox(height: 30),
            roundedRectBorderWidget('Post a short video', 'reel', context),
          ],
        ),
      ),
    );
  }

  Widget roundedRectBorderWidget(
      String text, String action, BuildContext context) {
    return DottedBorder(
      color: const Color(0xFFCDEB3F),
      borderType: BorderType.RRect,
      radius: const Radius.circular(15),
      padding: const EdgeInsets.all(6),
      child: ClipRRect(
        //borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: OutlinedButton(
          onPressed: () {
            // Define your button action here
            if (action == 'discussion') {
              print('discussion pressed with push to discussion page');
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => PostDiscussionScreen(
              //       toggleBottomNavBarVisibility: (bool) {
              //         widget.toggleBottomNavBarVisibility(bool);
              //       },
              //     ),
              //   ),
              // );
            } else if (action == 'reel') {
              print('reel pressed');
            }
          },
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(320, 60),
            side: BorderSide.none,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Text(
            text,
            style: GoogleFonts.roboto(
              textStyle: const TextStyle(color: Colors.white),
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
