import 'package:flutter/material.dart';

final List<BottomNavigationBarItem> bottomTabs = [
  const BottomNavigationBarItem(
      icon: Icon(
        Icons.home,
      ),
      label: "Home"),
  const BottomNavigationBarItem(
    icon: Icon(
      Icons.search,
    ),
    label: "Search",
  ),
  const BottomNavigationBarItem(
    icon: Icon(
      Icons.video_library_sharp,
    ),
    label: "library",
  ),
  const BottomNavigationBarItem(
      icon: Icon(
        Icons.menu,
      ),
      label: "Menu")
];
