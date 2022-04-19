import 'package:coolicons/coolicons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final List<BottomNavigationBarItem> bottomTabs = [
  const BottomNavigationBarItem(
    icon: Icon(Coolicons.home_alt_fill),
    label: "Home",
  ),
  const BottomNavigationBarItem(
    icon: FaIcon(FontAwesomeIcons.searchengin),
    label: "Search",
  ),
  const BottomNavigationBarItem(
    icon: Icon(
      Icons.video_library_outlined,
    ),
    label: "library",
  ),
  const BottomNavigationBarItem(
    icon: FaIcon(FontAwesomeIcons.bars),
    label: "Menu",
  )
];
