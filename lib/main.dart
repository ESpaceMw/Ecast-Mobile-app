import 'package:ecast/Services/router.dart';
import 'package:ecast/Utils/constants.dart';
import 'package:ecast/Utils/getter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  await setupServiceLocator();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) {
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter().generateRoute,
      theme: ThemeData(
        fontFamily: 'OpenSans',
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black54,
        primaryColor: whiteColor,
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontSize: 25,
            // fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ));
  });
}
