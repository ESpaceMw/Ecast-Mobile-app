import 'package:ecast/Services/api.dart';
import 'package:ecast/Services/repos/repo.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const kBackgroundColor = Color(0xFF181818);
const kPrimaryColor = Color(0xFFFFBD73);
const btnColor = Color(0xFF2AB7B1);
const whiteColor = Colors.white;
const errorColor = Colors.red;
const scaffoldColor = Color(0xFF101010);
const selectedIten = Color(0xFF5ED0FB);
final codeColor = Colors.grey[900];
const recColor = Color(0xFF1A1A1A);
final iconColor = Colors.grey[700];
final GlobalKey<State> keyLoader = GlobalKey<State>();

final TextEditingController email = TextEditingController();
final TextEditingController password = TextEditingController();
DateTime pickedDate = DateTime.now();
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
bool Playing = false;

List recentlyPlayed = [];

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

const priceStyles = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 18,
);

const planStyles = TextStyle(
  fontWeight: FontWeight.w600,
  fontSize: 14,
);

const packageStyles = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 20,
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
const playlistInput = '/add_playlist';

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

// plan list
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

// why join premium list
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

// plan details const list
List<Widget> plandetails = [
  Container(
    width: 1000,
    decoration: BoxDecoration(
        color: kBackgroundColor, borderRadius: BorderRadius.circular(10.0)),
    child: Column(
      children: const [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Solo Package",
            textAlign: TextAlign.center,
            style: packageStyles,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Solo Daily',
          style: planStyles,
        ),
        Text(
          'MK 250',
          style: priceStyles,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Solo Weekly',
          style: planStyles,
        ),
        Text(
          'MK 1,500',
          style: priceStyles,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Solo Monthly',
          style: planStyles,
        ),
        Text(
          'MK 5,000',
          style: priceStyles,
        ),
        SizedBox(
          height: 10,
        ),
      ],
    ),
  ),
  Container(
    width: 1000,
    decoration: BoxDecoration(
        color: kBackgroundColor, borderRadius: BorderRadius.circular(10.0)),
    child: Column(
      children: const [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Duo Package",
            textAlign: TextAlign.center,
            style: packageStyles,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Duo Weekly',
          style: planStyles,
        ),
        Text(
          'MK 2,500',
          style: priceStyles,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Duo Monthly',
          style: planStyles,
        ),
        Text(
          'MK 7,500',
          style: priceStyles,
        ),
        SizedBox(
          height: 10,
        ),
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
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Squad Package",
            textAlign: TextAlign.center,
            style: packageStyles,
          ),
        ),
        SizedBox(
          height: 8.0,
        ),
        Text("Max 5 people"),
        SizedBox(
          height: 10,
        ),
        Text(
          'Squad Weekly',
          style: planStyles,
        ),
        Text(
          'MK 3,500',
          style: priceStyles,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Squad Monthly',
          style: planStyles,
        ),
        Text(
          'MK 10,000',
          style: priceStyles,
        ),
        SizedBox(
          height: 10,
        ),
      ],
    ),
  )
];
