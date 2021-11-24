import 'package:ecast/Utils/constants.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            const SizedBox(
              width: 80,
            ),
            Column(
              children: const [
                Text(
                  "Nhlanhla Dhaka",
                  style: textStyle,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text('I love God , i love people'),
                )
              ],
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Container(),
        ListTile(
          leading: Container(
            padding: const EdgeInsets.all(15.0),
            decoration: boxColor,
            child: const Icon(
              Icons.wallet_travel,
              color: whiteColor,
              size: 30,
            ),
          ),
          title: const Text(
            "Premium",
            style: textStyle,
          ),
          trailing: const Icon(
            Icons.arrow_forward_rounded,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        ListTile(
          leading: Container(
            padding: const EdgeInsets.all(15.0),
            decoration: boxColor,
            child: const Icon(
              Icons.table_chart,
              color: whiteColor,
              size: 30,
            ),
          ),
          title: const Text(
            "Charts",
            style: textStyle,
          ),
          trailing: const Icon(
            Icons.arrow_forward_rounded,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        ListTile(
          leading: Container(
            padding: const EdgeInsets.all(15.0),
            decoration: boxColor,
            child: const Icon(
              Icons.notes_outlined,
              color: whiteColor,
              size: 30,
            ),
          ),
          title: const Text(
            "Notes",
            style: textStyle,
          ),
          trailing: const Icon(
            Icons.arrow_forward_rounded,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        ListTile(
          leading: Container(
            padding: const EdgeInsets.all(15.0),
            decoration: boxColor,
            child: const Icon(
              Icons.help,
              color: whiteColor,
              size: 30,
            ),
          ),
          title: const Text(
            "Help",
            style: textStyle,
          ),
          trailing: const Icon(
            Icons.arrow_forward_rounded,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        ListTile(
          leading: Container(
            padding: const EdgeInsets.all(15.0),
            decoration: boxColor,
            child: const Icon(
              Icons.info,
              color: whiteColor,
              size: 30,
            ),
          ),
          title: const Text(
            "About",
            style: textStyle,
          ),
          trailing: const Icon(
            Icons.arrow_forward_rounded,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        ListTile(
          leading: Container(
            padding: const EdgeInsets.all(15.0),
            decoration: boxColor,
            child: const Icon(
              Icons.settings,
              color: whiteColor,
              size: 30,
            ),
          ),
          title: const Text(
            "Settings",
            style: textStyle,
          ),
          trailing: const Icon(
            Icons.arrow_forward_rounded,
          ),
        )
      ],
    );
  }
}
