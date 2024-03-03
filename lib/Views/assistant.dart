import 'package:flutter/material.dart';

class assistant extends StatelessWidget {
  const assistant({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CareGuardian'), // Replace 'Your App Name' with your actual app name
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'This is the main content of your Diabetes page.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}