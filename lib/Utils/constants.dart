import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const kBackgroundColor = Color(0xFF202020);
const kPrimaryColor = Color(0xFFFFBD73);
const btnColor = Color(0xFF337d78);
const whiteColor = Colors.white;
const errorColor = Colors.red;
const codeColor = Color(0xFF37474F);
final GlobalKey<State> keyLoader = GlobalKey<State>();
var baseUrl = 'http://10.0.2.2:8000';

final TextEditingController email = TextEditingController();
final TextEditingController password = TextEditingController();

Future<SharedPreferences> state() {
  return SharedPreferences.getInstance();
}

const textStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
);

const info = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.bold,
);

const snackBarText = TextStyle(
  color: whiteColor,
  fontSize: 17,
);

const btnStyle = BoxDecoration(
  color: btnColor,
  borderRadius: BorderRadius.all(
    Radius.circular(
      8.6,
    ),
  ),
);

BoxDecoration boxColor = BoxDecoration(
  color: codeColor,
  borderRadius: BorderRadius.circular(
    10.6,
  ),
);

List<String> genders = ["M", "F"];

const splash = "/";
const wrapper = "/wrapper";
const signUp = "/signup";
const signIn = "/signin";
const home = "/home";
const note = "/notes";
const forgetPassword = "/forgotpassword";
