import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PostDiscussionTitleTextbox extends StatefulWidget {
  final TextEditingController postTitleController;
  const PostDiscussionTitleTextbox(
      {super.key, required this.postTitleController});

  @override
  State<PostDiscussionTitleTextbox> createState() =>
      _PostDiscussionTitleTextboxState();
}

class _PostDiscussionTitleTextboxState
    extends State<PostDiscussionTitleTextbox> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.postTitleController;
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _controller,
            maxLength: 75,
            decoration: InputDecoration(
              hintText: "Give your post a title",
              hintStyle: GoogleFonts.roboto(
                textStyle: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
