import 'package:careguardian/themes/routes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    final logo = Image.asset(
      "images/logo.png",
      height: mq.size.height / 4,
    );

    final emailField = TextFormField(
      enabled: !isSubmitting,
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

    final passwordField = Column(
      children: <Widget>[
        TextFormField(
          enabled: !isSubmitting,
          controller: _passwordController,
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
            labelText: "Password",
            labelStyle: TextStyle(
              color: Colors.white,
            ),
            hintStyle: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        const Padding(padding: EdgeInsets.all(2.0)),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            MaterialButton(
              child: Text(
                "Forgot Password",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white),
              ),
              onPressed: () {
                // TODO: Create forgot password popup
              },
            ),
          ],
        )
      ],
    );

    final fields = Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[emailField, passwordField],
      ),
    );

    final loginButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 5.0, backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
      onPressed: () async {
        try {
          UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _emailController.text,
            password: _passwordController.text,
          );

          if (userCredential.user != null) {
            // Use pushNamedAndRemoveUntil to clear the navigation history
            Navigator.pushNamedAndRemoveUntil(context, AppRoutes.menu, (route) => false);
          }
        } catch (e) {
          print(e);
          _emailController.text = "";
          _passwordController.text = "";
        }
      },
      child: Container(
        width: mq.size.width / 1.2,
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: const Center(
          child: Text(
            "Login",
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );

    final bottom = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Padding(padding: EdgeInsets.all(8.0)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Not a Member",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Colors.white,
              ),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.authRegister);
              },
              child: Text(
                "Sign Up",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.white, decoration: TextDecoration.underline),
              ),
            )
          ],
        )
      ],
    );

    return Scaffold(
      backgroundColor: Colors.blue,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(36),
          child: SizedBox(
            height: mq.size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                logo,
                fields,
                loginButton,
                bottom,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
