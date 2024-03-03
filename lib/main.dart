import 'dart:io';
import 'package:careguardian/themes/routes.dart';
import 'package:flutter/material.dart';
import 'package:careguardian/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Bypass SSL certificate verification for development (not recommended for production)
  HttpOverrides.global = MyHttpOverrides();

  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CareGuardian',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white, // Set background color to white
      ),
      routes: AppRoutes.define(),
      home: const SplashScreen(),
    );
  }
}
