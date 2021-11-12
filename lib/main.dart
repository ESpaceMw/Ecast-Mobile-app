import 'package:ecast/Screens/splash_screen.dart';
import 'package:ecast/Utils/constants.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: kBackgroundColor,
      primaryColor: kPrimaryColor,
    ),
    routes: {
      '/': (context) => const SplashScreen(),
    },
  ));
}
