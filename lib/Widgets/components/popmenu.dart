import 'package:ecast/Utils/constants.dart';
import 'package:flutter/material.dart';

class Popmenu extends StatelessWidget {
  const Popmenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      itemBuilder: (context) {
        return options.map((e) {
          return PopupMenuItem(
            value: e,
            child: Text(e),
          );
        }).toList();
      },
      // onSelected: (String choice) {
      //   if (choice == "") {
      //     showAboutDialog(
      //         context: context,
      //         applicationName: "Synop",
      //         applicationVersion: "1.2.2",
      //         children: [
      //           Text(
      //             'This app was designed and built by Rodger Kumwanje',
      //           ),
      //         ]);
      //   } else {}
      // },
    );
  }
}
