import 'package:ecast/Screens/profile.dart';
import 'package:ecast/Utils/constants.dart';
import 'package:ecast/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserCubit>(context).userProfile();
    return ListView(
      children: [
        const SizedBox(
          height: 20,
        ),
        BlocConsumer<UserCubit, UserState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is FetchedUser) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Profile()));
                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        "assets/logos/user.png",
                        width: MediaQuery.of(context).size.width * 0.2,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        Text(
                          state.user['username'],
                          style: textStyle,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(state.user['email']),
                        )
                      ],
                    )
                  ],
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
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, podcats);
          },
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.all(15.0),
              decoration: boxColor,
              child: const Icon(
                Icons.podcasts,
                color: whiteColor,
                size: 30,
              ),
            ),
            title: const Text(
              "Podcasts",
              style: textStyle,
            ),
            trailing: const Icon(
              Icons.arrow_forward_rounded,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, charts);
          },
          child: ListTile(
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
        ),
        const SizedBox(
          height: 20,
        ),
        BlocListener<UserCubit, UserState>(
          listener: (context, state) {
            if (state is logginout) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Row(
                      children: const [
                        CircularProgressIndicator(
                          color: btnColor,
                        ),
                        Text("Signing Out")
                      ],
                    );
                  });
            }

            if (state is Logout) {
              Navigator.pushReplacementNamed(context, wrapper);
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
                child: const Icon(
                  Icons.logout_outlined,
                  size: 30,
                ),
              ),
              title: const Text(
                "Logout",
                style: textStyle,
              ),
            ),
          ),
        )
      ],
    );
  }
}
