import 'package:flutter/material.dart';
import 'package:careguardian/Views/login_screen.dart';
import 'package:careguardian/Views/register_screen.dart';
import 'package:careguardian/Views/menu.dart';  // Adjust the path accordingly

class AppRoutes {
  AppRoutes._();

  static const String authLogin = '/auth-login';
  static const String authRegister = '/auth-register';
  static const String menu = '/menu';

  static Map<String, WidgetBuilder> define() {
    return {
      authLogin: (context) => const Login(),
      authRegister: (context) => const Register(),
      menu: (context) => const MenuScreen()  // Make sure the import and class name are correct
    };
  }
}
