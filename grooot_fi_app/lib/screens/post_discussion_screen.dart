import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grooot_fi_app/components/choose_post_category.dart';

class PostDiscussionScreen extends StatelessWidget {
  final Function(bool) toggleBottomNavBarVisibility;
  final ValueNotifier<Map<String, dynamic>> postDataNotifier;

  const PostDiscussionScreen({
    super.key,
    required this.toggleBottomNavBarVisibility,
    required this.postDataNotifier,
  });

  void _showBottomSheet(BuildContext context) {
    toggleBottomNavBarVisibility(false);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      barrierColor: const Color(0xFF2C2C2C).withOpacity(0.9),
      builder: (context) {
        return ChoosePostCategory(
          onOptionSelected: (String imageUrl, String title) {
            postDataNotifier.value = {
              ...postDataNotifier.value,
              'selectedImageUrl': imageUrl,
              'selectedTitle': title,
            };
            Navigator.of(context).pop();
          },
        );
      },
    ).whenComplete(() {
      toggleBottomNavBarVisibility(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Unfocus the text field (close the keyboard) when tapping outside of text fields
      onTap: () {
        FocusScope.of(context).unfocus(); // This will close the keyboard
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Create a post',
            style: GoogleFonts.roboto(
              textStyle: const TextStyle(color: Colors.white),
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
              color: Colors.white,
              height: 1.0,
            ),
          ),
          toolbarHeight: 50,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              GestureDetector(
                onTap: () => _showBottomSheet(context),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2C2C2C),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ValueListenableBuilder<Map<String, dynamic>>(
                      valueListenable: postDataNotifier,
                      builder: (context, postData, child) {
                        final imageUrl = postData['selectedImageUrl'];
                        final title = postData['selectedTitle'];

                        if (imageUrl != null && title != null) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ClipOval(
                                child: Image.network(
                                  imageUrl,
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  title,
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
                            ],
                          );
                        } else {
                          return Row(
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
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ValueListenableBuilder<Map<String, dynamic>>(
                  valueListenable: postDataNotifier,
                  builder: (context, postData, child) {
                    return TextField(
                      controller: TextEditingController.fromValue(
                        TextEditingValue(
                          text: postData[
                              'postTitle'], // Bind to the postTitle value in the map
                          selection: TextSelection.fromPosition(
                            TextPosition(offset: postData['postTitle'].length),
                          ),
                        ),
                      ),
                      onChanged: (text) {
                        postDataNotifier.value = {
                          ...postDataNotifier.value,
                          'postTitle': text,
                        };
                      },
                      decoration: InputDecoration(
                        hintText: "Give your post a title",
                        hintStyle: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                      ),
                      maxLength: 75,
                      style: GoogleFonts.roboto(
                        textStyle:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ValueListenableBuilder<Map<String, dynamic>>(
                  valueListenable: postDataNotifier,
                  builder: (context, postData, child) {
                    return TextField(
                      controller: TextEditingController.fromValue(
                        TextEditingValue(
                          text: postData[
                              'postDescription'], // Bind to the postDescription value
                          selection: TextSelection.fromPosition(
                            TextPosition(
                                offset: postData['postDescription'].length),
                          ),
                        ),
                      ),
                      onChanged: (text) {
                        postDataNotifier.value = {
                          ...postDataNotifier.value,
                          'postDescription': text,
                        };
                      },
                      decoration: InputDecoration(
                        hintText: "Describe your post",
                        hintStyle: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                              color: Colors.white, fontSize: 14),
                        ),
                        border: InputBorder.none, // Remove the default border
                        enabledBorder: InputBorder
                            .none, // Remove the underline when not focused
                        focusedBorder: InputBorder
                            .none, // Remove the underline when focused
                      ),
                      style: GoogleFonts.roboto(
                        textStyle:
                            const TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      maxLines: 10,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
