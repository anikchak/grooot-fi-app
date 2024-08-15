import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PostDiscussionDescribePostTextbox extends StatefulWidget {
  const PostDiscussionDescribePostTextbox({super.key});

  @override
  State<PostDiscussionDescribePostTextbox> createState() =>
      _PostDiscussionDescribePostTextboxState();
}

class _PostDiscussionDescribePostTextboxState
    extends State<PostDiscussionDescribePostTextbox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          TextField(
            maxLines: 10, // Allows the text field to grow as the user types
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              hintText: "Describe your post",
              hintStyle: GoogleFonts.roboto(
                textStyle: const TextStyle(color: Colors.white, fontSize: 14),
              ),
              border: InputBorder.none, // Remove the default border
              enabledBorder:
                  InputBorder.none, // Remove the underline when not focused
              focusedBorder:
                  InputBorder.none, // Remove the underline when focused
            ),
          ),
        ],
      ),
    );
  }
}
