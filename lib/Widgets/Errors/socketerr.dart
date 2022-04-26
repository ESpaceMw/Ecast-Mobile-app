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
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/server_down.svg',
              width: MediaQuery.of(context).size.width * 0.5,
            ),
            const SizedBox(height: 10),
            Text(widget.msg),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
