import 'package:ecast/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Info extends StatefulWidget {
  final dynamic userDetail;
  const Info({Key? key, required this.userDetail}) : super(key: key);

  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String date = DateFormat('y').format(now).toString();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.userDetail['first_name'],
              style: textStyle,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              widget.userDetail['last_name'],
              style: textStyle,
            )
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          widget.userDetail['email'],
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     const Text('Bio'),
        //     Text(widget.userDetail['bio'] ?? 'Hello, this is my ecast bio'),
        //   ],
        // )

        // ignore: unnecessary_null_comparison
        // users != null
        //     ? Column(
        //         crossAxisAlignment: CrossAxisAlignment.center,
        //         children: [
        //           Row(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               Text(
        //                 users['first_name'] + "  " + users['last_name'],
        //                 style: textStyle,
        //               ),
        //             ],
        //           ),
        //           const SizedBox(
        //             height: 15,
        //           ),
        //           Text(
        //             users['email'],
        //             style: info,
        //           ),
        //           const SizedBox(
        //             height: 15,
        //           ),
        //           Text(
        //             users['phone_number'],
        //             style: info,
        //           ),
        //           const SizedBox(
        //             height: 10,
        //           ),
        //           Text(
        //             users['country'],
        //             style: info,
        //           ),
        //           const SizedBox(
        //             height: 10,
        //           ),
        //           ElevatedButton(
        //             onPressed: () {},
        //             child: const Text("Edit Profile"),
        //           ),
        //           const SizedBox(
        //             height: 30,
        //           ),
        //           Row(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               const Icon(Icons.copyright_outlined),
        //               const Text("eSpace "),
        //               Text(date),
        //             ],
        //           )
        //         ],
        //       )
        //     : const CircularProgressIndicator(
        //         color: btnColor,
        //       )
      ],
    );
  }
}
