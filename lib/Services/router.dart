import 'package:ecast/Screens/forgotpassword.dart';
import 'package:ecast/Screens/home_screen.dart';
import 'package:ecast/Screens/notes.dart';
import 'package:ecast/Screens/sign_in_screen.dart';
import 'package:ecast/Screens/sign_up_screen.dart';
import 'package:ecast/Screens/splash_screen.dart';
import 'package:ecast/Screens/wrapper.dart';
import 'package:ecast/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> _State() {
  return SharedPreferences.getInstance();
}

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    final prefs = _State().then((value) => value.getBool("loggedin"));
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case wrapper:
        return MaterialPageRoute(
          // ignore: unrelated_type_equality_checks
          builder: (_) => prefs == true ? const HomeScreen() : const Wrapper(),
        );
      case signUp:
        return MaterialPageRoute(
          builder: (_) => const SignUp(),
        );
      case signIn:
        return MaterialPageRoute(
          builder: (_) => const SignIn(),
        );
      case home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case note:
        return MaterialPageRoute(
          builder: (_) => const Notes(),
        );
      case forgetPassword:
        return MaterialPageRoute(
          builder: (_) => const ForgotPassword(),
        );
      default:
        return null;
    }
  }
}
