import 'package:coolicons/coolicons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

List<PersistentBottomNavBarItem> bottomTabs() {
  return [
    PersistentBottomNavBarItem(
      icon: const Icon(Coolicons.home_alt_fill),
      title: "Home",
    ),
    PersistentBottomNavBarItem(
      icon: const FaIcon(FontAwesomeIcons.searchengin),
      title: "Search",
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(
        Icons.video_library_outlined,
      ),
      title: "library",
    ),
    PersistentBottomNavBarItem(
      icon: const FaIcon(FontAwesomeIcons.bars),
      title: "Menu",
    )
  ];
}
