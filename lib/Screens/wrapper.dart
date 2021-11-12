import 'package:ecast/Utils/constants.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Navigator.pushNamed(context, '/signup');
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
                "Sign Up",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/signin');
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
                'Sign In',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
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
