import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Tftd extends StatefulWidget {
  const Tftd({super.key});

  @override
  _TftdState createState() => _TftdState();
}

class _TftdState extends State<Tftd> {
  String dailyQuote = 'Loading quote...';

  @override
  void initState() {
    super.initState();
    // Fetch and set a random quote when the widget is first created
    fetchRandomQuote();
  }

  Future<void> fetchRandomQuote() async {
    try {
      final response = await http.get(Uri.parse('https://api.quotable.io/random'));

      if (response.statusCode == 200) {
        // Parse the response and extract the quote content and author
        final decodedResponse = jsonDecode(response.body);
        final quoteContent = decodedResponse['content'];
        final quoteAuthor = decodedResponse['author'];

        setState(() {
          dailyQuote = 'Quote for the day:\n"$quoteContent" - $quoteAuthor';
        });
      } else {
        // Handle errors, such as no internet connection or server errors
        setState(() {
          dailyQuote = 'Failed to load quote';
        });
      }
    } catch (error) {
      // Handle other potential errors
      setState(() {
        dailyQuote = 'An error occurred';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CareGuardian'), // Replace 'Your App Name' with your actual app name
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              dailyQuote,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: fetchRandomQuote,
              child: const Text('Get New Quote'),
            ),
          ],
        ),
      ),
    );
  }
}
