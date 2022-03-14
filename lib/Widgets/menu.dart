import 'package:ecast/Models/user_model.dart';
import 'package:ecast/Screens/charts_screen.dart';
import 'package:ecast/Screens/profile.dart';
import 'package:ecast/Utils/constants.dart';
import 'package:ecast/Utils/loader.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:shared_preferences/shared_preferences.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  // var url = 'http://10.0.2.2:8000/api/user';
  List<User> parseUser(String responseBody) {
    final parsed =
        convert.jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }

  var user = 'user';
  _getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map userMap = convert.jsonDecode(prefs.getString("user").toString());
    setState(() {
      user = userMap['first_name'] + " " + userMap['last_name'];
    });
  }

  @override
  void initState() {
    _getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const Profile()));
          },
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  "assets/logos/user.png",
                  width: MediaQuery.of(context).size.width * 0.2,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                children: [
                  Text(
                    user,
                    style: textStyle,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text('Dude'),
                  )
                ],
              )
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/premium');
          },
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.all(15.0),
              decoration: boxColor,
              child: const Icon(
                Icons.wallet_travel,
                color: whiteColor,
                size: 30,
              ),
            ),
            title: const Text(
              "Premium",
              style: textStyle,
            ),
            trailing: const Icon(
              Icons.arrow_forward_rounded,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ChartsScreen()));
          },
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.all(15.0),
              decoration: boxColor,
              child: const Icon(
                Icons.table_chart,
                color: whiteColor,
                size: 30,
              ),
            ),
            title: const Text(
              "Charts",
              style: textStyle,
            ),
            trailing: const Icon(
              Icons.arrow_forward_rounded,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/notes'),
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.all(15.0),
              decoration: boxColor,
              child: const Icon(
                Icons.notes_outlined,
                color: whiteColor,
                size: 30,
              ),
            ),
            title: const Text(
              "Notes",
              style: textStyle,
            ),
            trailing: const Icon(
              Icons.arrow_forward_rounded,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        ListTile(
          leading: Container(
            padding: const EdgeInsets.all(15.0),
            decoration: boxColor,
            child: const Icon(
              Icons.help,
              color: whiteColor,
              size: 30,
            ),
          ),
          title: const Text(
            "Help",
            style: textStyle,
          ),
          trailing: const Icon(
            Icons.arrow_forward_rounded,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        ListTile(
          leading: Container(
            padding: const EdgeInsets.all(15.0),
            decoration: boxColor,
            child: const Icon(
              Icons.info,
              color: whiteColor,
              size: 30,
            ),
          ),
          title: const Text(
            "About",
            style: textStyle,
          ),
          trailing: const Icon(
            Icons.arrow_forward_rounded,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        ListTile(
          leading: Container(
            padding: const EdgeInsets.all(15.0),
            decoration: boxColor,
            child: const Icon(
              Icons.settings,
              color: whiteColor,
              size: 30,
            ),
          ),
          title: const Text(
            "Settings",
            style: textStyle,
          ),
          trailing: const Icon(
            Icons.arrow_forward_rounded,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setBool("loggedin", false);
            prefs.setString("user", "");
            prefs.setString("token", "");
            Navigator.pushReplacementNamed(context, wrapper);
          },
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.all(15.0),
              decoration: boxColor,
              child: const Icon(
                Icons.logout_outlined,
                size: 30,
              ),
            ),
            title: const Text(
              "Logout",
              style: textStyle,
            ),
          ),
        )
      ],
    );
  }
}
