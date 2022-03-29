import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const kBackgroundColor = Color(0xFF101010);
const kPrimaryColor = Color(0xFFFFBD73);
const btnColor = Color(0xFF337d78);
const whiteColor = Colors.white;
const errorColor = Colors.red;
const selectedIten = Color(0xFF5ED0FB);
const codeColor = Color(0xFF37474F);
const recColor = Color(0xFF1A1A1A);
final GlobalKey<State> keyLoader = GlobalKey<State>();


final TextEditingController email = TextEditingController();
final TextEditingController password = TextEditingController();
final TextEditingController username = TextEditingController();
final TextEditingController confirmed = TextEditingController();

Future<bool?> state() async {
  final SharedPreferences item = await SharedPreferences.getInstance();
  // return item.getBool("loggedin");
  return item.getBool("loggedin");
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

// routes
const splash = "/";
const wrapper = "/wrapper";
const signUp = "/signup";
const signIn = "/signin";
const home = "/home";
const note = "/notes";
const forgetPassword = "/forgotpassword";
const charts = '/charts';
