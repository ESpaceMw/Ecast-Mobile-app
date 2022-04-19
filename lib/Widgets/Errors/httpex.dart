import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HttpExc extends StatelessWidget {
  final String msg;
  const HttpExc({Key? key, required this.msg}) : super(key: key);

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
            Text(msg),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
