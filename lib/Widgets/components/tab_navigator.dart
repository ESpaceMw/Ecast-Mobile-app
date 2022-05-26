import 'package:ecast/Screens/screen_options.dart';
import 'package:flutter/material.dart';

class TabNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;
  const TabNavigator(
      {Key? key, required this.navigatorKey, required this.tabItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child = tabBodies[0];
    if (tabItem == 'page1') {
      child = tabBodies[0];
    } else if (tabItem == 'page2') {
      child = tabBodies[1];
    } else if (tabItem == 'page3') {
      child = tabBodies[2];
    } else if (tabItem == 'page4') {
      child = tabBodies[3];
    }
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) => child);
      },
    );
  }
}
