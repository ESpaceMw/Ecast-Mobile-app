import 'package:ecast/Services/api.dart';
import 'package:ecast/Services/repos/repo.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const kBackgroundColor = Color(0xFF101010);
const kPrimaryColor = Color(0xFFFFBD73);
const btnColor = Color(0xFF2AB7B1);
const whiteColor = Colors.white;
const errorColor = Colors.red;
const selectedIten = Color(0xFF5ED0FB);
final codeColor = Colors.grey[900];
const recColor = Color(0xFF1A1A1A);
final iconColor = Colors.grey[700];
final GlobalKey<State> keyLoader = GlobalKey<State>();

final TextEditingController email = TextEditingController();
final TextEditingController password = TextEditingController();
final TextEditingController username = TextEditingController();
final TextEditingController confirmed = TextEditingController();
final TextEditingController firstname = TextEditingController();
final TextEditingController lastname = TextEditingController();
final TextEditingController country = TextEditingController();
final TextEditingController city = TextEditingController();
final TextEditingController phone = TextEditingController();
final TextEditingController birthdate = TextEditingController();
// final TextEditingController gender = TextEditingController();
final TextEditingController playlistName = TextEditingController();

String gender = 'Male';
List<String> gvals = ['Male', 'Female', 'Non-Binary'];
List RecentlyPlayed = [];
bool playing = false;

bool playAll = false;

const optStyles = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.bold,
);

const podstyles = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 13,
);

const textStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
);

const titleStyles = TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.bold,
);

const extreStyles = TextStyle(
  color: Colors.grey,
  fontWeight: FontWeight.bold,
  fontSize: 17,
);

const infostyle = TextStyle(
  fontSize: 14,
);

const info = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.bold,
);

const snackBarText = TextStyle(
  color: whiteColor,
  fontSize: 17,
);

const btnStyle = BoxDecoration(
  color: btnColor,
  borderRadius: BorderRadius.all(
    Radius.circular(
      8.6,
    ),
  ),
);

BoxDecoration boxColor = BoxDecoration(
  color: codeColor,
  borderRadius: BorderRadius.circular(
    10.6,
  ),
);

List<String> genders = ["M", "F"];

// routes
const splash = "/";
const wrapper = "/wrapper";
const signUp = "/signup";
const signIn = "/signin";
const home = "/home";
const note = "/notes";
const forgetPassword = "/forgotpassword";
const charts = '/charts';
const podcats = '/podcasts';
const ep = '/ep';

List<String> options = [
  'Note',
  'Download'
      'Details'
];

List genres = [
  {'art_url': '', 'title': 'Arts'},
  {'art_url': "", 'title': ''},
];

Repository repository = Repository(networkService: NetworkService());

List<Widget> plans = [
  Container(
    width: 1000,
    decoration: BoxDecoration(
      color: btnColor,
      borderRadius: BorderRadius.circular(
        10.0,
      ),
    ),
    child: const Center(
        child: Text(
      'Solo Packages',
    )),
  ),
  Container(
    width: 1000,
    decoration: BoxDecoration(
      color: btnColor,
      borderRadius: BorderRadius.circular(
        10.0,
      ),
    ),
    child: const Center(
        child: Text(
      'Duo Package',
    )),
  ),
  Container(
    width: 1000,
    decoration: BoxDecoration(
      color: btnColor,
      borderRadius: BorderRadius.circular(
        10.0,
      ),
    ),
    child: const Center(
        child: Text(
      'Squad',
    )),
  )
];

List<Widget> reslits = [
  Row(
    children: const [
      SizedBox(
        width: 9.0,
      ),
      FaIcon(
        FontAwesomeIcons.check,
        color: btnColor,
        size: 20,
      ),
      SizedBox(
        width: 9.0,
      ),
      Text('Download to Listen offline without Wifi')
    ],
  ),
  const SizedBox(
    height: 9.0,
  ),
  Row(
    children: const [
      SizedBox(
        width: 9.0,
      ),
      FaIcon(
        FontAwesomeIcons.check,
        color: btnColor,
        size: 20,
      ),
      SizedBox(
        width: 9.0,
      ),
      Text('Music and Podcasts without ad interuptions')
    ],
  ),
  const SizedBox(
    height: 9.0,
  ),
  Row(
    children: const [
      SizedBox(
        width: 9.0,
      ),
      FaIcon(
        FontAwesomeIcons.check,
        color: btnColor,
        size: 20,
      ),
      SizedBox(
        width: 9.0,
      ),
      Text('High sound quality Music and Podcasts')
    ],
  ),
  const SizedBox(
    height: 9.0,
  ),
  Row(
    children: const [
      SizedBox(
        width: 9.0,
      ),
      FaIcon(
        FontAwesomeIcons.check,
        color: btnColor,
        size: 20,
      ),
      SizedBox(
        width: 9.0,
      ),
      Text('Play songs in desired order, without shuffling')
    ],
  ),
  const SizedBox(
    height: 9.0,
  ),
  Row(
    children: const [
      SizedBox(
        width: 9.0,
      ),
      FaIcon(
        FontAwesomeIcons.check,
        color: btnColor,
        size: 20,
      ),
      SizedBox(
        width: 9.0,
      ),
      Text(
        'Pick and Play any Track on Mobile',
      )
    ],
  )
];

List<Widget> plandetails = [
  Container(
    width: 1000,
    decoration: BoxDecoration(
        color: kBackgroundColor, borderRadius: BorderRadius.circular(10.0)),
    child: Column(
      children: const [
        Text(
          "Solo",
          textAlign: TextAlign.center,
          style: textStyle,
        )
      ],
    ),
  ),
  Container(
    width: 1000,
    decoration: BoxDecoration(
        color: kBackgroundColor, borderRadius: BorderRadius.circular(10.0)),
    child: Column(
      children: const [
        Text(
          "Pro",
          textAlign: TextAlign.center,
          style: textStyle,
        )
      ],
    ),
  ),
  Container(
    width: 1000,
    decoration: BoxDecoration(
      color: kBackgroundColor,
      borderRadius: BorderRadius.circular(
        10.0,
      ),
    ),
    child: Column(
      children: const [
        Text(
          "Solo",
          textAlign: TextAlign.center,
          style: textStyle,
        ),
      ],
    ),
  )
];
