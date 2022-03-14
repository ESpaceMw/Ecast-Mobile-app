import 'package:ecast/Screens/screen_options.dart';
import 'package:ecast/Utils/constants.dart';
import 'package:ecast/Widgets/bottom_nav_options.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabBodies[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: bottomTabs,
        selectedItemColor: selectedIten,
        showUnselectedLabels: false,
        iconSize: 30,
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: _onTapItem,
      ),
    );
  }

  void _onTapItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
