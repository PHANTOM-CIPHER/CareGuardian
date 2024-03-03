import 'package:careguardian/themes/routes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    final logo = Image.asset(
      "images/logo.png",
      height: mq.size.height / 4,
    );

    final usernameField = TextFormField(
      controller: _usernameController,
      style: const TextStyle(
        color: Colors.white,
      ),
      cursorColor: Colors.white,
      decoration: const InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        hintText: "",
        labelText: "Username",
        labelStyle: TextStyle(
          color: Colors.white,
        ),
        hintStyle: TextStyle(
          color: Colors.white,
        ),
      ),
    );

    final emailField = TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(
        color: Colors.white,
      ),
      cursorColor: Colors.white,
      decoration: const InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        hintText: "",
        labelText: "Email",
        labelStyle: TextStyle(
          color: Colors.white,
        ),
        hintStyle: TextStyle(
          color: Colors.white,
        ),
      ),
    );

    final passwordField = TextFormField(
      controller: _passwordController,
      style: const TextStyle(
        color: Colors.white,
      ),
      cursorColor: Colors.white,
      obscureText: true,
      decoration: const InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        hintText: "",
        labelText: "Password",
        labelStyle: TextStyle(
          color: Colors.white,
        ),
        hintStyle: TextStyle(
          color: Colors.white,
        ),
      ),
    );

    final repasswordField = TextFormField(
      controller: _repasswordController,
      style: const TextStyle(
        color: Colors.white,
      ),
      cursorColor: Colors.white,
      obscureText: true,
      decoration: const InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        hintText: "",
        labelText: "Re-Enter Password",
        labelStyle: TextStyle(
          color: Colors.white,
        ),
        hintStyle: TextStyle(
          color: Colors.white,
        ),
      ),
    );

    final fields = Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          usernameField,
          emailField,
          passwordField,
          repasswordField,
        ],
      ),
    );

    final registerButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 5.0, backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
      onPressed: () async {
        try {
          UserCredential? userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text,
            password: _passwordController.text,
          );

          if (userCredential.user != null) {
            await userCredential.user?.updateDisplayName(_usernameController.text);
            // Use pushNamedAndRemoveUntil to clear the navigation history
            Navigator.pushNamedAndRemoveUntil(context, AppRoutes.menu, (route) => false);
          }
        } catch (e) {
          print(e);
          // TODO: Show alert dialog with error
          _usernameController.text = "";
          _passwordController.text = "";
          _repasswordController.text = "";
          _emailController.text = "";
        }
      },
      child: Container(
        width: mq.size.width / 1.2,
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: const Text(
          "Register",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    final forgotPasswordButton = MaterialButton(
      child: Text(
        "Forgot Password",
        style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white),
      ),
      onPressed: () {
        // TODO: Create forgot password popup
      },
    );

    final alreadyHaveAccount = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "Already have an account?",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Colors.white,
          ),
        ),
        MaterialButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AppRoutes.authLogin);
          },
          child: Text(
            "Login",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Colors.black,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(36),
          height: mq.size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              logo,
              fields,
              registerButton,
              forgotPasswordButton,
              alreadyHaveAccount,
            ],
          ),
        ),
      ),
    );
  }
}
