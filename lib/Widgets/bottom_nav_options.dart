import 'package:coolicons/coolicons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

List<BottomNavigationBarItem> bottomTabs = const [
  BottomNavigationBarItem(
    icon: Icon(Coolicons.home_alt_fill),
    label: "Home",
  ),
  BottomNavigationBarItem(
    icon: FaIcon(FontAwesomeIcons.searchengin),
    label: "Search",
  ),
  BottomNavigationBarItem(
    icon: Icon(
      Icons.video_library_outlined,
    ),
    label: "library",
  ),
  BottomNavigationBarItem(
    icon: FaIcon(FontAwesomeIcons.bars),
    label: "Menu",
  )
];
