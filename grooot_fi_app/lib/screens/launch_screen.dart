import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({super.key});

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFCDEB3F),
        child: Center(
          child: Text(
            'grooot',
            style: GoogleFonts.fredoka(
              textStyle: const TextStyle(
                  fontSize: 80,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}
