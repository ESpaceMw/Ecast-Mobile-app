import 'package:flutter/material.dart';

void searchData(String text) async {
  // TODO implement search algorithm
}

String timeChecker(int time) {
  if (time <= 12) {
    return "Good Morning";
  } else if ((time > 12) && (time <= 16)) {
    return "Good Afternoon";
  }
  return "Good Evening";
}
