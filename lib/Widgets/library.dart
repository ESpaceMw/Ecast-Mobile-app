import 'package:ecast/Services/api.dart';
import 'package:ecast/Services/repos/repo.dart';
import 'package:ecast/Utils/constants.dart';
import 'package:ecast/Widgets/components/downloads.dart';
import 'package:ecast/Widgets/components/playlist.dart';
import 'package:ecast/Widgets/components/playlistinput.dart';
import 'package:ecast/Widgets/components/subscription.dart';
import 'package:ecast/Widgets/components/top_tab_options.dart';
import 'package:ecast/cubit/podcasts_cubit.dart';
import 'package:ecast/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Library extends StatefulWidget {
  const Library({Key? key}) : super(key: key);

  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  int _currentBuild = 0;
  final ScrollController _Controller = ScrollController();
  Repository repository = Repository(networkService: NetworkService());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(
          left: 15,
          right: 15,
        ),
        child: ListView(
          shrinkWrap: true,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "Library",
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: const FaIcon(
                    FontAwesomeIcons.plus,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              margin: const EdgeInsets.only(left: 5),
              child: Row(
                children: [
                  _buildTabs(0),
                  _buildTabs(1),
                  _buildTabs(2),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              child: _currentBuild == 0
                  ? BlocProvider(
                      create: (context) =>
                          PodcastsCubit(repository: repository),
                      child: const Subscriptions(),
                    )
                  : _currentBuild == 1
                      ? const Downloads()
                      : BlocProvider(
                          create: (context) =>
                              UserCubit(repository: repository),
                          child: const Playlist(),
                        ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTabs(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentBuild = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(left: 5),
        decoration: BoxDecoration(
          color: _currentBuild == index ? btnColor : null,
          borderRadius: BorderRadius.circular(
            6,
          ),
        ),
        child: tabs[index],
      ),
    );
  }
}
