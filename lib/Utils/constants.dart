import 'package:ecast/Services/api.dart';
import 'package:ecast/Services/repos/repo.dart';
import 'package:flutter/material.dart';

const kBackgroundColor = Color(0xFF101010);
const kPrimaryColor = Color(0xFFFFBD73);
const btnColor = Color(0xFF337d78);
const whiteColor = Colors.white;
const errorColor = Colors.red;
const selectedIten = Color(0xFF5ED0FB);
const codeColor = Color(0xFF37474F);
const recColor = Color(0xFF1A1A1A);
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
String gender = 'Male';
List<String> gvals = ['Male', 'Female', 'Non-Binary'];
List RecentlyPlayed = [];
var Playing = [];

bool playAll = false;

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
  fontSize: 16,
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

Repository repository = Repository(networkService: NetworkService());

                    // return Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Container(
                    //         margin: EdgeInsets.only(
                    //           top: MediaQuery.of(context).size.height * 0.14,
                    //         ),
                    //         child: CarouselSlider.builder(
                    //           itemCount: state.charts.length,
                    //           itemBuilder: (context, index, data) {
                    //             return GestureDetector(
                    //               onTap: () {
                    //                 Navigator.of(context).push(
                    //                   MaterialPageRoute(
                    //                     builder: (_) => ViewChart(
                    //                       chartDetails: state.charts[index],
                    //                     ),
                    //                   ),
                    //                 );
                    //               },
                    //               child: ClipRRect(
                    //                   borderRadius: const BorderRadius.all(
                    //                       Radius.circular(5.0)),
                    //                   child: Stack(
                    //                     children: <Widget>[
                    //                       Image.network(
                    //                           state.charts[index]
                    //                               ['header_image'],
                    //                           fit: BoxFit.cover,
                    //                           width: MediaQuery.of(context)
                    //                               .size
                    //                               .width),
                    //                       Positioned(
                    //                         bottom: 0.0,
                    //                         left: 0.0,
                    //                         right: 0.0,
                    //                         child: Container(
                    //                           decoration: const BoxDecoration(
                    //                             gradient: LinearGradient(
                    //                               colors: [
                    //                                 Color.fromARGB(
                    //                                     200, 0, 0, 0),
                    //                                 Color.fromARGB(200, 0, 0, 0)
                    //                               ],
                    //                               begin: Alignment.bottomCenter,
                    //                               end: Alignment.topCenter,
                    //                             ),
                    //                           ),
                    //                           padding:
                    //                               const EdgeInsets.symmetric(
                    //                                   vertical: 10.0,
                    //                                   horizontal: 20.0),
                    //                           child: Text(
                    //                             state.charts[index]['name'],
                    //                             style: const TextStyle(
                    //                                 color: Colors.white,
                    //                                 fontSize: 20.0,
                    //                                 fontWeight: FontWeight.bold,
                    //                                 fontFamily: 'OpenSans'),
                    //                           ),
                    //                         ),
                    //                       ),
                    //                     ],
                    //                   )),
                    //             );
                    //           },
                    //           options: CarouselOptions(
                    //               aspectRatio: 2.0, enlargeCenterPage: true),
                    //         )),
                    //     const Padding(
                    //       padding: EdgeInsets.all(10.0),
                    //       child: Text("Recommended Podcasts", style: textStyle),
                    //     ),
                    //     const SizedBox(
                    //       height: 10,
                    //     ),
                    //     GridView.builder(
                    //       shrinkWrap: true,
                    //       physics: const ScrollPhysics(),
                    //       gridDelegate:
                    //           SliverGridDelegateWithFixedCrossAxisCount(
                    //         crossAxisCount: 2,
                    //         mainAxisSpacing: 4.0,
                    //         childAspectRatio:
                    //             MediaQuery.of(context).size.width /
                    //                 (MediaQuery.of(context).size.height / 1.6),
                    //       ),
                    //       itemCount: state.podcasts.length,
                    //       itemBuilder: (context, index) {
                    //         return GestureDetector(
                    //           onTap: () {
                    //             Navigator.of(context).push(
                    //               MaterialPageRoute(
                    //                   builder: (context) => BlocProvider.value(
                    //                         value: PodcastsCubit(
                    //                             repository: repos),
                    //                         child: ViewPodcast(
                    //                             details: state.podcasts[index]),
                    //                       )),
                    //             );
                    //           },
                    //           child: Container(
                    //             margin: const EdgeInsets.all(10),
                    //             decoration: BoxDecoration(
                    //               color: recColor,
                    //               borderRadius: BorderRadius.circular(10),
                    //             ),
                    //             child: Column(
                    //               mainAxisAlignment: MainAxisAlignment.start,
                    //               children: [
                    //                 Flexible(
                    //                   child: Padding(
                    //                     padding: const EdgeInsets.only(top: 13),
                    //                     child: ClipRRect(
                    //                       borderRadius:
                    //                           BorderRadius.circular(18),
                    //                       child: CachedNetworkImage(
                    //                         width: MediaQuery.of(context)
                    //                                 .size
                    //                                 .width *
                    //                             0.37,
                    //                         imageUrl: state.podcasts[index]
                    //                             ['cover_art'],
                    //                         placeholder: (context, url) =>
                    //                             const Center(
                    //                           child: CircularProgressIndicator(
                    //                             color: btnColor,
                    //                           ),
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 ),
                    //                 Padding(
                    //                   padding: const EdgeInsets.all(10.0),
                    //                   child: Text(
                    //                     state.podcasts[index]['title'],
                    //                     style: const TextStyle(
                    //                       fontWeight: FontWeight.bold,
                    //                       fontSize: 16,
                    //                     ),
                    //                     textAlign: TextAlign.start,
                    //                   ),
                    //                 )
                    //               ],
                    //             ),
                    //           ),
                    //         );
                    //       },
                    //     )
                    //   ],
                    // );
