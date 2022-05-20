import 'package:ecast/Utils/constants.dart';
import 'package:flutter/material.dart';

class CirculaIndicator extends StatelessWidget {
  const CirculaIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.3,
      ),
      child: const Center(
        child: CircularProgressIndicator(
          color: btnColor,
        ),
      ),
    );
  }
}
