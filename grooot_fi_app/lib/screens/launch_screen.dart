import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grooot_fi_app/screens/home_screen.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({super.key});

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  void initState() {
    super.initState();
    print("init invoked");
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFCDEB3F),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'grooot',
                style: GoogleFonts.fredoka(
                  textStyle: const TextStyle(
                      fontSize: 80,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
