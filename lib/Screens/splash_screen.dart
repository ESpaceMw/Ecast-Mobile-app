import 'package:ecast/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void delay() async {
    await Future.delayed(
        const Duration(seconds: 3),
        () => {
              Navigator.pushReplacementNamed(context, '/wrapper'),
            });
  }

  @override
  void initState() {
    super.initState();
    delay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: sized_box_for_whitespace
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: const AssetImage('assets/logos/logo.png'),
                width: MediaQuery.of(context).size.width * 0.8,
              ),
              const SpinKitThreeBounce(
                color: kPrimaryColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
