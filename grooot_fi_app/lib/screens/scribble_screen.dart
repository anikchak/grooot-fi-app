import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScribbleScreen extends StatefulWidget {
  const ScribbleScreen({super.key});

  @override
  State<ScribbleScreen> createState() => _ScribbleScreenState();
}

class _ScribbleScreenState extends State<ScribbleScreen> {
  Map<int, bool> expandedStates =
      {}; // Track expanded states for each container
  String description =
      //"This is a long description text that should demonstrate the 'show more' and 'show less' functionality. "
      //"It will truncate to 7 lines if not expanded, and upon clicking 'show more', it will reveal the full text."
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum";

  @override
  Widget build(BuildContext context) {
    Future<void> refreshFeedContent() async {
      // Simulate some network or data refresh delay
      await Future.delayed(const Duration(seconds: 2));

      // After refreshing, you can update the UI or data
      setState(() {
        // Update any state or data here if needed
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "What's the buzz",
          style: GoogleFonts.roboto(
            textStyle: const TextStyle(color: Colors.white),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 16.0, 8.0),
            child: GestureDetector(
              onTap: () {
                // Action for the Post button
              },
              child: const Icon(
                Icons.add_rounded,
                size: 35,
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
      body: RefreshIndicator(
        onRefresh: refreshFeedContent,
        child: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
            bool isExpanded = expandedStates[index] ?? false;
            return Container(
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.blueAccent.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        radius: 30, // Adjust size as needed
                        backgroundImage: AssetImage(
                            'assets/images/avatar.png'), // Provide your image path
                      ),
                      const SizedBox(
                          width: 16), // Spacing between image and text
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Taxation',
                            style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFCDEB3F),
                              ),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'posted by anikchak',
                            style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            )),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'I made 1cr+ this year, how do I save some tax on this amount?',
                        style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            expandedStates[index] =
                                !(expandedStates[index] ?? false);
                          });
                        },
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: isExpanded
                                    ? description
                                    : '${description.split(' ').take(50) // Approximation to fit 7 lines
                                        .join(' ')}...',
                                style: GoogleFonts.roboto(
                                  textStyle: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              if (!isExpanded)
                                TextSpan(
                                  text: ' show more',
                                  style: GoogleFonts.roboto(
                                    textStyle: const TextStyle(
                                      fontSize: 14,
                                      color: Color(
                                          0xFFCDEB3F), // Use any color you prefer
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      if (isExpanded)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              expandedStates[index] = false;
                            });
                          },
                          child: const Text(
                            "show less",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFFCDEB3F),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
