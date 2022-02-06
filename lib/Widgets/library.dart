import 'package:ecast/Utils/constants.dart';
import 'package:ecast/Widgets/components/downloads.dart';
import 'package:ecast/Widgets/components/subscription.dart';
import 'package:ecast/Widgets/components/top_tab_options.dart';
import 'package:flutter/material.dart';

class Library extends StatefulWidget {
  const Library({Key? key}) : super(key: key);

  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  int _currentBuild = 0;
  final ScrollController _Controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: _Controller,
      shrinkWrap: true,
      children: [
        const SizedBox(
          height: 15,
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Library",
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            _buildTabs(0),
            _buildTabs(1),
            _buildTabs(2),
          ],
        ),
        Container(
          child: _currentBuild == 0
              ? const Subscriptions()
              : _currentBuild == 1
                  ? const Downloads()
                  : const Center(
                      child: Text("Dude"),
                    ),
        )
      ],
    );
  }

  Widget _buildTabs(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentBuild = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.only(left: 5),
        color: _currentBuild == index ? codeColor.withGreen(100) : null,
        child: tabs[index],
      ),
    );
  }
}
