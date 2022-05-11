import 'package:coolicons/coolicons.dart';
import 'package:ecast/Screens/screen_options.dart';
import 'package:ecast/Utils/constants.dart';
import 'package:ecast/Widgets/bottom_nav_options.dart';
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
  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabBodies[_selectedIndex],
      bottomNavigationBar: Container(
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // ignore: avoid_unnecessary_containers
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.play_circle,
                    // size: 10,
                  )
                ],
              ),
            ),
            BottomNavigationBar(
              items: bottomTabs,
              onTap: _changeIndex,
              showUnselectedLabels: false,
              selectedItemColor: btnColor,
              unselectedItemColor: whiteColor,
              currentIndex: _selectedIndex,
              backgroundColor: kBackgroundColor,
            ),
          ],
        ),
      ),
    );
  }

  void _changeIndex(index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

// PersistentTabView(
//         context,
//         controller: _controller,
//         navBarStyle: NavBarStyle.style10,
//         navBarHeight: 60,
//         items: [
//           PersistentBottomNavBarItem(
//             icon: const Icon(Coolicons.home_alt_fill),
//             title: "Home",
//             activeColorPrimary: btnColor,
//             activeColorSecondary: whiteColor,
//             inactiveColorPrimary: Colors.white,
//             textStyle: const TextStyle(
//               fontSize: 15,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           PersistentBottomNavBarItem(
//             icon: const FaIcon(FontAwesomeIcons.searchengin),
//             title: "Search",
//             activeColorPrimary: btnColor,
//             activeColorSecondary: whiteColor,
//             inactiveColorPrimary: Colors.white,
//             textStyle: const TextStyle(
//               fontSize: 15,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           PersistentBottomNavBarItem(
//             icon: const Icon(
//               Icons.video_library_outlined,
//             ),
//             title: "library",
//             activeColorPrimary: btnColor,
//             activeColorSecondary: whiteColor,
//             inactiveColorPrimary: Colors.white,
//             textStyle: const TextStyle(
//               fontSize: 15,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           PersistentBottomNavBarItem(
//             icon: const FaIcon(FontAwesomeIcons.bars),
//             title: "Menu",
//             activeColorPrimary: btnColor,
//             activeColorSecondary: whiteColor,
//             inactiveColorPrimary: Colors.white,
//             textStyle: const TextStyle(
//               fontSize: 15,
//               fontWeight: FontWeight.bold,
//             ),
//           )
//         ],
//         screens: tabBodies,
//         stateManagement: true,
//         backgroundColor: kBackgroundColor,
//       ),
