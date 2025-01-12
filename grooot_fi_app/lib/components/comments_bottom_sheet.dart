import 'package:flutter/material.dart';

class CommentsBottomSheet extends StatefulWidget {
  final Future<List<String>> commentsFuture; // Fetch comments dynamically
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
  final TextEditingController commentController = TextEditingController();
  final FocusNode commentFocusNode = FocusNode();
  late Future<List<String>> cachedFuture;

  @override
  void initState() {
    super.initState();
    cachedFuture = widget.commentsFuture; // Cache the future in initState
  }

  @override
  void dispose() {
    commentController.dispose();
    commentFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
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
          final comments = commentData.data ?? [];

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
                      const Text(
                        "Comments here",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
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
                                      "User ${index + 1}",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      comments[index],
                                      style: const TextStyle(fontSize: 14),
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
                          controller: commentController,
                          focusNode: commentFocusNode,
                          onTap: () {
                            // When tapped, ensure the keyboard opens
                            commentFocusNode.requestFocus();
                          },
                          decoration: InputDecoration(
                            hintText: "Add a comment...",
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
                          if (commentController.text.isNotEmpty) {
                            widget.onCommentAdded();
                            commentController.clear(); // Clear the input
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
