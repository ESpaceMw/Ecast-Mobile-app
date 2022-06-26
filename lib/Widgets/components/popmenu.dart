import 'package:ecast/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Popmenu extends StatelessWidget {
  const Popmenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const FaIcon(FontAwesomeIcons.bars),
      itemBuilder: (context) {
        return options.map((e) {
          return PopupMenuItem(
            value: e,
            child: Text(e),
          );
        }).toList();
      },
    );
  }
}
