import 'package:ecast/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

class Info extends StatefulWidget {
  const Info({Key? key}) : super(key: key);

  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  var user = 'user';
  late Map users = {
    "first_name": "John",
    "last_name": "Doe",
    "email": "johnDoe@gmail.com",
    "country": "Country",
    "phone_number": "123456789"
  };
  _getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map userMap = convert.jsonDecode(prefs.getString("user").toString());
    setState(() {
      users = userMap;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUserData();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String date = DateFormat('y').format(now).toString();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 30,
        ),
        Image.asset(
          'assets/logos/user.png',
          width: MediaQuery.of(context).size.width * 0.3,
        ),
        const SizedBox(
          height: 15,
        ),
        // ignore: unnecessary_null_comparison
        users != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        users['first_name'] + "  " + users['last_name'],
                        style: textStyle,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    users['email'],
                    style: info,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    users['phone_number'],
                    style: info,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    users['country'],
                    style: info,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text("Edit Profile"),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.copyright_outlined),
                      const Text("eSpace "),
                      Text(date),
                    ],
                  )
                ],
              )
            : const CircularProgressIndicator(
                color: btnColor,
              )
      ],
    );
  }
}
