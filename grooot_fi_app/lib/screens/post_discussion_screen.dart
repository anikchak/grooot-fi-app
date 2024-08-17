import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grooot_fi_app/components/post_discussion_describe_post_textbox.dart';
import 'package:grooot_fi_app/components/post_discussion_title_textbox.dart';

class PostDiscussionScreen extends StatefulWidget {
  final Function(bool) toggleBottomNavBarVisibility;
  const PostDiscussionScreen(
      {super.key, required this.toggleBottomNavBarVisibility});

  @override
  State<PostDiscussionScreen> createState() => _PostDiscussionScreenState();
}

class _PostDiscussionScreenState extends State<PostDiscussionScreen> {
  int currentBottomNavPageIndex = 2;

  void _showBottomSheet(BuildContext context) {
    widget.toggleBottomNavBarVisibility(false);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      barrierColor: const Color(0xFF2C2C2C).withOpacity(0.9),
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.85,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                        width: 24), // Placeholder to center the title
                    Text(
                      "Choose a community",
                      style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              // Add more content to the bottom sheet here if needed
            ],
          ),
        );
      },
    ).whenComplete(() {
      widget.toggleBottomNavBarVisibility(true);
    });
  }

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
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 16.0, 8.0),
            child: TextButton(
              onPressed: () {
                // Action for the Post button
              },
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFFCDEB3F),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                minimumSize: const Size(80, 20),
              ),
              child: Text(
                "Post",
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
          ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(
            color: Colors.white, // Customize the color of the divider
            height: 1.0,
          ),
        ),
        toolbarHeight: 50,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () => _showBottomSheet(context),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 10.0,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2C2C2C),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Choose a community",
                        style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                              color: Colors.white, fontSize: 17),
                        ),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const PostDiscussionTitleTextbox(),
            const SizedBox(height: 20),
            const PostDiscussionDescribePostTextbox(),
          ],
        ),
      ),
    );
  }
}
