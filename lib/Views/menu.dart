import 'package:flutter/material.dart';
import 'package:careguardian/Views/diabetes.dart';
import 'package:careguardian/Views/copd.dart';
import 'package:careguardian/Views/sos.dart';
import 'package:careguardian/Views/chatbot.dart';
import 'package:careguardian/Views/assistant.dart';
import 'package:careguardian/Views/tftd.dart';
import 'package:careguardian/Views/opening_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CareGuardian',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.tealAccent),
      ),
      home: MenuScreen(),
    );
  }
}

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CareGuardian',
          style: TextStyle(fontSize: 24.0, color: Colors.white),
        ),
        backgroundColor: Colors.indigo,
        centerTitle: true,
        toolbarHeight: 80.0,
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(16.0),
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: 0.8,
              children: [
                CircularButton('Diabetes', Icons.favorite, DiabetesPredictionPage(), fontSize: 18.0),
                CircularButton('Heart Disease', Icons.favorite, HeartDiseasePredictionPage(), fontSize: 18.0),
                CircularButton('Parkinson Disease', Icons.warning, ParkinsonsPredictionPage(), fontSize: 18.0),
                CircularButton('Quote For Today', Icons.format_quote, Tftd(), fontSize: 18.0),
              ],
            ),
          ),
          Container(
            height: 80.0,
            color: Colors.indigo,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.logout, color: Colors.white, size: 30.0),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => OpeningView()),
                          (route) => false,
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.chat_bubble, color: Colors.white, size: 30.0),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChatbotScreen()),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.person_pin, color: Colors.white, size: 30.0),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => assistant()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CircularButton extends StatelessWidget {
  final String buttonText;
  final IconData icon;
  final Widget destinationPage;
  final double fontSize;

  const CircularButton(
      this.buttonText,
      this.icon,
      this.destinationPage, {
        Key? key,
        this.fontSize = 24.0,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationPage),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.indigo,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40.0,
                color: Colors.white,
              ),
              SizedBox(height: 8.0),
              Text(
                buttonText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
