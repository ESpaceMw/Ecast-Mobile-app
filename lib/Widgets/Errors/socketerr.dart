import 'package:ecast/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocketErr extends StatefulWidget {
  final String msg;
  const SocketErr({Key? key, required this.msg}) : super(key: key);

  @override
  State<SocketErr> createState() => _SocketErrState();
}

class _SocketErrState extends State<SocketErr> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            Text(
              widget.msg,
              style: textStyle,
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
