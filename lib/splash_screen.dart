import 'dart:async';
import 'package:flutter/material.dart';
import 'package:careguardian/views/opening_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Use Future.delayed instead of Timer for better readability
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => OpeningView(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mq = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: mq.size.height * 0.5, // Adjust the height as needed
              child: Image.asset("images/logo.png"),
            ),
            const SizedBox(height: 5), // Add some spacing
            const Text(
              'CareGuardian',
              style: TextStyle(
                fontSize: 50, // Adjust font size as needed
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
