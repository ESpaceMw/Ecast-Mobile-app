import 'package:flutter/material.dart';

const kBackgroundColor = Color(0xFF202020);
const kPrimaryColor = Color(0xFFFFBD73);
const btnColor = Color(0xFF337d78);
const whiteColor = Colors.white;
const errorColor = Colors.red;
const codeColor = Color(0xFF37474F);
final GlobalKey<State> keyLoader = GlobalKey<State>();
var url = 'http://10.0.2.2:8000';

const textStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
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
