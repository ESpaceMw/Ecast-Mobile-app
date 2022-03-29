import 'package:ecast/Services/router.dart';
import 'package:ecast/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    onGenerateRoute: AppRouter().generateRoute,
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
  ));
}
