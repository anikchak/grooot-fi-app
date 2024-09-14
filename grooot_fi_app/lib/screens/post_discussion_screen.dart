import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grooot_fi_app/components/choose_post_category.dart';
import 'package:grooot_fi_app/components/post_discussion_describe_post_textbox.dart';
import 'package:grooot_fi_app/components/post_discussion_title_textbox.dart';

class PostDiscussionScreen extends StatefulWidget {
  final Function(bool) toggleBottomNavBarVisibility;
  final TextEditingController postTitleController;
  const PostDiscussionScreen(
      {super.key,
      required this.toggleBottomNavBarVisibility,
      required this.postTitleController});

  @override
  State<PostDiscussionScreen> createState() => _PostDiscussionScreenState();
}

class _PostDiscussionScreenState extends State<PostDiscussionScreen> {
  String? selectedImageUrl;
  String? selectedTitle;
  void _showBottomSheet(BuildContext context) {
    widget.toggleBottomNavBarVisibility(false);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      barrierColor: const Color(0xFF2C2C2C).withOpacity(0.9),
      builder: (context) {
        return ChoosePostCategory(
          onOptionSelected: (String imageUrl, String title) {
            setState(() {
              selectedImageUrl = imageUrl;
              selectedTitle = title;
            });
            Navigator.of(context).pop();
          },
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
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        //   icon: const Icon(
        //     Icons.arrow_back_ios_new_rounded,
        //     color: Colors.white,
        //   ),
        // ),
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (selectedImageUrl != null &&
                          selectedTitle != null) ...[
                        ClipOval(
                          child: Image.network(
                            selectedImageUrl!,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          // To ensure the title takes up the remaining space and aligns left
                          child: Text(
                            selectedTitle!,
                            style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 30,
                        ),
                      ] else ...[
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
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            PostDiscussionTitleTextbox(
                postTitleController: widget.postTitleController),
            const SizedBox(height: 20),
            const PostDiscussionDescribePostTextbox(),
          ],
        ),
      ),
    );
  }
}
