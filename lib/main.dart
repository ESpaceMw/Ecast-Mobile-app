import 'package:ecast/Screens/home_screen.dart';
import 'package:ecast/Screens/sign_in_screen.dart';
import 'package:ecast/Screens/sign_up_screen.dart';
import 'package:ecast/Screens/splash_screen.dart';
import 'package:ecast/Screens/wrapper.dart';
import 'package:ecast/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: kBackgroundColor,
      primaryColor: whiteColor,
      textTheme: const TextTheme(
        headline1: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    routes: {
      '/': (context) => const SplashScreen(),
      '/wrapper': (context) => prefs.getBool("loggedin") == true
          ? const HomeScreen()
          : const Wrapper(),
      '/signin': (context) => const SignIn(),
      '/signup': (context) => const SignUp(),
      '/home': (context) => const HomeScreen()
    },
  ));
}
