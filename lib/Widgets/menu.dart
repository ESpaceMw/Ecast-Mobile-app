import 'package:carousel_slider/carousel_slider.dart';
import 'package:coolicons/coolicons.dart';
import 'package:ecast/Screens/about.dart';
import 'package:ecast/Screens/charts_screen.dart';
import 'package:ecast/Screens/profile.dart';
import 'package:ecast/Screens/wrapper.dart';
import 'package:ecast/Services/api.dart';
import 'package:ecast/Services/repos/repo.dart';
import 'package:ecast/Utils/constants.dart';
import 'package:ecast/Utils/loader.dart';
import 'package:ecast/cubit/charts_cubit.dart';
import 'package:ecast/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

Repository repository = Repository(networkService: NetworkService());

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserCubit>(context).userProfile();
    return Scaffold(
      backgroundColor: Colors.black54,
      body: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          BlocConsumer<UserCubit, UserState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is FetchedUser) {
                return Container(
                  margin: const EdgeInsets.only(left: 12),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Profile(
                                details: state.user,
                              )));
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "assets/logos/user.png",
                            width: MediaQuery.of(context).size.width * 0.15,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  state.user['first_name'] ?? 'First name',
                                  style: textStyle,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  state.user['last_name'] ?? 'last name',
                                  style: textStyle,
                                ),
                              ],
                            ),
                            Text(state.user['email'] ?? 'User email')
                          ],
                        )
                      ],
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            height: 110,
            child: CarouselSlider(
              items: plans,
              options: CarouselOptions(
                enlargeCenterPage: true,
                aspectRatio: 1.5,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => ChartsCubit(repository: repository),
                    child: const ChartsScreen(),
                  ),
                ),
              );
            },
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(15.0),
                decoration: boxColor,
                child: Icon(
                  Icons.table_chart,
                  color: iconColor,
                  size: 23,
                ),
              ),
              title: const Text(
                "Charts",
                style: textStyle,
              ),
              trailing: const FaIcon(
                FontAwesomeIcons.angleRight,
                size: 20,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/notes'),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(15.0),
                decoration: boxColor,
                child: Icon(
                  Coolicons.note,
                  color: iconColor,
                  size: 23,
                ),
              ),
              title: const Text(
                "Notes",
                style: textStyle,
              ),
              trailing: const FaIcon(
                FontAwesomeIcons.angleRight,
                size: 20,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(15.0),
              decoration: boxColor,
              child: Icon(
                Icons.help,
                color: iconColor,
                size: 23,
              ),
            ),
            title: const Text(
              "Help",
              style: textStyle,
            ),
            trailing: const FaIcon(
              FontAwesomeIcons.angleRight,
              size: 20,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => const About(),
                ),
              );
            },
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(15.0),
                decoration: boxColor,
                child: Icon(
                  Icons.info,
                  color: iconColor,
                  size: 23,
                ),
              ),
              title: const Text(
                "About",
                style: textStyle,
              ),
              trailing: const FaIcon(
                FontAwesomeIcons.angleRight,
                size: 20,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(15.0),
              decoration: boxColor,
              child: Icon(
                Icons.settings,
                color: iconColor,
                size: 23,
              ),
            ),
            title: const Text(
              "Settings",
              style: textStyle,
            ),
            trailing: const FaIcon(
              FontAwesomeIcons.angleRight,
              size: 20,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          BlocListener<UserCubit, UserState>(
            listener: (context, state) {
              if (state is logginout) {
                Dialogs.showLoadingDialog(context, keyLoader, state.msg);
              } else if (state is Logout) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.msg),
                  ),
                );
                pushNewScreen(
                  context,
                  screen: const Wrapper(),
                  withNavBar: false,
                );
              }
            },
            child: GestureDetector(
              onTap: () async {
                BlocProvider.of<UserCubit>(context).signout();
              },
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: boxColor,
                  child: Icon(
                    Icons.logout_outlined,
                    size: 23,
                    color: iconColor,
                  ),
                ),
                title: const Text(
                  "Logout",
                  style: textStyle,
                ),
                trailing: const FaIcon(FontAwesomeIcons.angleRight),
              ),
            ),
          )
        ],
      ),
    );
  }
}
