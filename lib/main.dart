import 'package:ecast/Screens/sign_in_screen.dart';
import 'package:ecast/Screens/splash_screen.dart';
import 'package:ecast/Screens/wrapper.dart';
import 'package:ecast/Utils/constants.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: kBackgroundColor,
    ),
    routes: {
      '/': (context) => const SplashScreen(),
      '/wrapper': (context) => const Wrapper(),
      '/signin': (context) => const SignIn()
    },
  ));
}
