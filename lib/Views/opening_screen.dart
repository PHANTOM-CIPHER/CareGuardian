import 'package:careguardian/themes/routes.dart';
import 'package:flutter/material.dart';

class OpeningView extends StatelessWidget {
  const OpeningView({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    final logo = Image.asset(
      "images/logo.png",
      height: mq.size.height / 4,
    );

    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.white,
      child: MaterialButton(
        minWidth: mq.size.width / 1.2,
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: const Text(
          "Login",
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.authLogin);
        },
      ),
    );

    final registerButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.white,
      child: MaterialButton(
        minWidth: mq.size.width / 1.2,
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: const Text(
          "Register",
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.authRegister);
        },
      ),
    );

    final buttons = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        loginButton,
        const SizedBox(height: 10.0), // Adjusted space between logo and buttons
        registerButton,
      ],
    );

    return Scaffold(
      backgroundColor: Colors.blue,
      body: Padding(
        padding: const EdgeInsets.all(36),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20), // Adjusted space between logo and top
              child: logo,
            ),
            buttons,
          ],
        ),
      ),
    );
  }
}
