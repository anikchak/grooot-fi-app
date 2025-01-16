import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grooot_fi_app/datamodels/post_comment_data_model.dart';

class CommentsBottomSheet extends StatefulWidget {
  final Future<PostCommentDataModel>
      commentsFuture; // Fetch comments dynamically
  final VoidCallback onCommentAdded; // Callback for adding new comments

  const CommentsBottomSheet({
    Key? key,
    required this.commentsFuture,
    required this.onCommentAdded,
  }) : super(key: key);

  @override
  State<CommentsBottomSheet> createState() => _CommentsBottomSheetState();
}

class _CommentsBottomSheetState extends State<CommentsBottomSheet> {
  final TextEditingController _commentController = TextEditingController();
  final FocusNode commentFocusNode = FocusNode();
  late Future<PostCommentDataModel> cachedFuture;
  List<PostComment> comments = [];
  @override
  void initState() {
    super.initState();
    cachedFuture = widget.commentsFuture; // Cache the future in initState
  }

  @override
  void dispose() {
    _commentController.dispose();
    commentFocusNode.dispose();
    super.dispose();
  }

  Future<void> _addComment(String commentText) async {
    print("Adding comment: $commentText");
    final newComment = PostComment(
      commentByUser: "Current User", // Replace with actual username
      comment: commentText,
    );

    // Simulate saving to backend and updating local state
    setState(() {
      comments.add(newComment); // Add the new comment to the list
    });

    // Optionally call backend here to save the comment
    // await yourBackendService.saveComment(newComment);

    widget.onCommentAdded(); // Notify parent about the addition
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PostCommentDataModel>(
      future: cachedFuture,
      builder: (context, commentData) {
        if (commentData.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 200,
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (commentData.hasError) {
          return SizedBox(
            height: 200,
            child: Center(
              child: Text('Error: ${commentData.error}'),
            ),
          );
        } else {
          comments = commentData.data?.data ?? [];

          return GestureDetector(
            // Dismiss the keyboard when tapping outside the input box
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              height: MediaQuery.of(context).size.height * 0.85,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Comments",
                        style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        )),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Colors.black,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                  const Divider(),

                  // Comments List
                  Expanded(
                    child: ListView.builder(
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CircleAvatar(
                                radius: 20,
                                backgroundImage:
                                    AssetImage('assets/images/avatar.png'),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      comments[index].commentByUser ??
                                          'Anonymous',
                                      style: GoogleFonts.roboto(
                                        textStyle: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      comments[index].comment,
                                      style: GoogleFonts.roboto(
                                        textStyle: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  // Add Comment Input Section
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _commentController,
                          focusNode: commentFocusNode,
                          onTap: () {
                            // When tapped, ensure the keyboard opens
                            commentFocusNode.requestFocus();
                          },
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                          decoration: InputDecoration(
                            hintText: "Add a comment...",
                            hintStyle: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                color: Colors.black54,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      IconButton(
                        icon: const Icon(Icons.send, color: Colors.blue),
                        onPressed: () {
                          _addComment(_commentController.text);
                          if (_commentController.text.isNotEmpty) {
                            _commentController.clear(); // Clear the input
                            commentFocusNode.unfocus(); // Dismiss the keyboard
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
