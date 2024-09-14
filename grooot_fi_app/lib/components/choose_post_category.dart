import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChoosePostCategory extends StatefulWidget {
  final Function(String, String) onOptionSelected;
  const ChoosePostCategory({super.key, required this.onOptionSelected});

  @override
  State<ChoosePostCategory> createState() => _ChoosePostCategoryState();
}

class _ChoosePostCategoryState extends State<ChoosePostCategory> {
  @override
  Widget build(BuildContext context) {
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
                const SizedBox(width: 24), // Placeholder to center the title
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
          Expanded(
            child: ListView(
              children: [
                _OptionItem(
                  imageUrl: 'https://via.placeholder.com/50',
                  title: 'Community 1',
                  description: 'This is a description of Community 1',
                  onOptionTap: widget.onOptionSelected,
                ),
                _OptionItem(
                  imageUrl: 'https://via.placeholder.com/50',
                  title: 'Community 2',
                  description: 'This is a description of Community 2',
                  onOptionTap: widget.onOptionSelected,
                ),
                _OptionItem(
                  imageUrl: 'https://via.placeholder.com/50',
                  title: 'Community 3',
                  description: 'This is a description of Community 3',
                  onOptionTap: widget.onOptionSelected,
                ),
                // Add more options as needed
              ],
            ),
          ),
          // Add more content to the bottom sheet here if needed
        ],
      ),
    );
  }
}

class _OptionItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final Function(String, String) onOptionTap;

  const _OptionItem({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.onOptionTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onOptionTap(imageUrl, title);
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipOval(
              child: Image.network(
                imageUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF2c2c2c),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
