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
  fontWeight: FontWeight.w700,
);

const titleStyles = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

const podTitleStyles = TextStyle(
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

List<String> options = ['Cast', 'Download'];

Repository repository = Repository(networkService: NetworkService());

// plan list
List<Widget> plans = [
  Container(
    width: 1000,
    child: Center(
      child: Image.asset(
        "assets/images/1.png",
      ),
    ),
  ),
  Container(
    width: 1000,
    child: Center(
      child: Image.asset(
        "assets/images/3.png",
      ),
    ),
  ),
  Container(
    width: 1000,
    child: Center(
      child: Image.asset(
        "assets/images/DUO.png",
      ),
    ),
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
  ClipRRect(
    borderRadius: BorderRadius.circular(
      10.0,
    ),
    child: Container(
        width: 3000,
        child: Image.asset(
          "assets/images/solo.png",
        )),
  ),
  ClipRRect(
      borderRadius: BorderRadius.circular(
        10.0,
      ),
      child: Container(child: Image.asset("assets/images/duo.png"))),
  ClipRRect(
      borderRadius: BorderRadius.circular(
        10.0,
      ),
      child: Container(child: Image.asset("assets/images/squad.png")))
];
