import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PostDiscussionDescribePostTextbox extends StatefulWidget {
  final TextEditingController postDescriptionController;

  const PostDiscussionDescribePostTextbox(
      {super.key, required this.postDescriptionController});

  @override
  State<PostDiscussionDescribePostTextbox> createState() =>
      _PostDiscussionDescribePostTextboxState();
}

class _PostDiscussionDescribePostTextboxState
    extends State<PostDiscussionDescribePostTextbox> {
  late TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = widget.postDescriptionController;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          TextField(
            controller: _controller,
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
