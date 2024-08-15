import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PostDiscussionTitleTextbox extends StatefulWidget {
  const PostDiscussionTitleTextbox({super.key});

  @override
  State<PostDiscussionTitleTextbox> createState() =>
      _PostDiscussionTitleTextboxState();
}

class _PostDiscussionTitleTextboxState
    extends State<PostDiscussionTitleTextbox> {
  final TextEditingController _controller = TextEditingController();
  int _charCount = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _charCount = _controller.text.length;
      });
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
