import 'package:ecast/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  void _log() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var log = prefs.getBool("loggedin");
    if (log == true) {
      Navigator.pushReplacementNamed(context, home);
    }
  }

  @override
  void initState() {
    _log();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // ignore: sized_box_for_whitespace
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Image(
            image: const AssetImage('assets/logos/logo.png'),
            width: MediaQuery.of(context).size.width * 0.7,
          ),
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/signin');
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              padding: const EdgeInsets.all(14.5),
              decoration: const BoxDecoration(
                color: btnColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    8.6,
                  ),
                ),
              ),
              child: const Text(
                "Sign In",
                textAlign: TextAlign.center,
                style: textStyle,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/signup');
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              padding: const EdgeInsets.all(14.6),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(width: 5, color: btnColor),
                  left: BorderSide(width: 5, color: btnColor),
                  bottom: BorderSide(width: 5, color: btnColor),
                  right: BorderSide(width: 5, color: btnColor),
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    8.6,
                  ),
                ),
              ),
              child: const Text(
                'Sign Up',
                textAlign: TextAlign.center,
                style: textStyle,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    ));
  }
}
