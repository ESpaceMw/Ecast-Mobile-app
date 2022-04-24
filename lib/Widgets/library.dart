import 'package:ecast/Services/api.dart';
import 'package:ecast/Services/repos/repo.dart';
import 'package:ecast/Utils/constants.dart';
import 'package:ecast/Widgets/components/downloads.dart';
import 'package:ecast/Widgets/components/subscription.dart';
import 'package:ecast/Widgets/components/top_tab_options.dart';
import 'package:ecast/cubit/podcasts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return Scaffold(
      backgroundColor: Colors.black87,
      body: ListView(
        controller: _Controller,
        shrinkWrap: true,
        children: [
          const SizedBox(
            height: 15,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Library",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              _buildTabs(0),
              _buildTabs(1),
              _buildTabs(2),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            child: _currentBuild == 0
                ? BlocProvider(
                    create: (context) => PodcastsCubit(repository: repository),
                    child: const Subscriptions(),
                  )
                : _currentBuild == 1
                    ? const Downloads()
                    : const Center(
                        child: Text("Dude"),
                      ),
          )
        ],
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
        padding: const EdgeInsets.all(8.0),
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
