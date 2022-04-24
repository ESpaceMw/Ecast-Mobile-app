import 'package:coolicons/coolicons.dart';
import 'package:ecast/Screens/screen_options.dart';
import 'package:ecast/Utils/constants.dart';
// import 'package:ecast/Widgets/bottom_nav_options.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PersistentTabController _controller;
  late bool _hideNavBar;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    _hideNavBar = false;
  }

  // int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,
        items: [
          PersistentBottomNavBarItem(
            icon: const Icon(Coolicons.home_alt_fill),
            title: "Home",
            activeColorPrimary: btnColor,
            activeColorSecondary: whiteColor,
            inactiveColorPrimary: Colors.white,
          ),
          PersistentBottomNavBarItem(
            icon: const FaIcon(FontAwesomeIcons.searchengin),
            title: "Search",
            activeColorPrimary: btnColor,
            activeColorSecondary: whiteColor,
            inactiveColorPrimary: Colors.white,
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          PersistentBottomNavBarItem(
            icon: const Icon(
              Icons.video_library_outlined,
            ),
            title: "library",
            activeColorPrimary: btnColor,
            activeColorSecondary: whiteColor,
            inactiveColorPrimary: Colors.white,
          ),
          PersistentBottomNavBarItem(
            icon: const FaIcon(FontAwesomeIcons.bars),
            title: "Menu",
            activeColorPrimary: btnColor,
            activeColorSecondary: whiteColor,
            inactiveColorPrimary: Colors.white,
          )
        ],
        screens: tabBodies,
        stateManagement: true,
        backgroundColor: kBackgroundColor,
      ),
    );

    // return Scaffold(
    //   backgroundColor: Colors.black87,
    //   body: tabBodies[_selectedIndex],
    //   bottomNavigationBar: BottomNavigationBar(
    //     items: bottomTabs,
    //     selectedItemColor: selectedIten,
    //     showUnselectedLabels: false,
    //     iconSize: 30,
    //     currentIndex: _selectedIndex,
    //     type: BottomNavigationBarType.fixed,
    //     onTap: _onTapItem,
    //   ),
    // );
  }

  // void _onTapItem(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }
}
