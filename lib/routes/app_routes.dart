import 'package:flutter/material.dart';

import 'package:aqua_mate/view/loginpage.dart';
import 'package:aqua_mate/view/signup.dart';
import 'package:aqua_mate/view/splash_screen.dart';

/// Central place to keep every named route used in the app.
class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String signup = '/signup';

  static Map<String, WidgetBuilder> get routes => {
        splash: (_) => const SplashScreen(),
        login: (_) => const LoginPage(),
        signup: (_) => const SignupPage(),
      };
}

