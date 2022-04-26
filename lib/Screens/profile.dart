import 'package:ecast/Utils/constants.dart';
import 'package:ecast/Widgets/components/espace.dart';
import 'package:ecast/Widgets/components/info.dart';
import 'package:ecast/Widgets/components/plan.dart';
import 'package:ecast/Widgets/components/top_tab_options.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  final dynamic details;

  const Profile({Key? key, required this.details}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int _currentTab = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.arrow_back_ios),
                ),
              ),
              const SizedBox(
                width: 70,
              ),
              _buildTabs(0),
              const SizedBox(
                width: 20,
              ),
              _buildTabs(1),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            child: _currentTab == 0
                ? Info(
                    userDetail: widget.details,
                  )
                : const Plan(),
          )
        ],
      ),
    );
  }

  Widget _buildTabs(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentTab = index;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: _currentTab == index ? codeColor.withGreen(100) : null,
          borderRadius: BorderRadius.circular(10.5),
        ),
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.only(left: 5, right: 5),
        child: profileTabs[index],
      ),
    );
  }
}
