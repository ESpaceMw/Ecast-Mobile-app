import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecast/Screens/podcasts_list.dart';
import 'package:ecast/Services/api.dart';
import 'package:ecast/Services/repos/repo.dart';
import 'package:ecast/Utils/constants.dart';
import 'package:ecast/cubit/podcasts_cubit.dart';
import 'package:ecast/cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Repository repository = Repository(networkService: NetworkService());

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchQuery = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black87,
      body: ListView(
        shrinkWrap: true,
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            margin: const EdgeInsets.only(left: 10, right: 10),
            decoration: const BoxDecoration(
              color: kBackgroundColor,
              borderRadius: BorderRadius.all(
                Radius.circular(
                  10.8,
                ),
              ),
            ),
            child: TextFormField(
              controller: _searchQuery,
              onTap: () => BlocProvider.of<SearchCubit>(context).searchOption(),
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.search_rounded,
                  // color: ,
                ),
                hintText: "Search",
                border: InputBorder.none,
              ),
              onFieldSubmitted: (String text) {
                BlocProvider.of<SearchCubit>(context).prev();
              },
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          BlocConsumer<SearchCubit, SearchState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              if (state is Searching) {
                return SafeArea(
                  child: ListView(
                    shrinkWrap: true,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 11, top: 2.0),
                        child: Text(
                          'Recent Searches',
                          style: info,
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return ListView(
                  shrinkWrap: true,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => BlocProvider.value(
                                value: PodcastsCubit(repository: repository),
                                child: const Podcasts()),
                          ),
                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 80,
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                          color: btnColor,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const Center(
                          child: Text(
                            'All Podcasts',
                            style: textStyle,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        bottom: 5.0,
                        left: 15.0,
                      ),
                      child: Text(
                        "Your Top Genres",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 120,
                      margin: const EdgeInsets.only(left: 7, right: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            Container(
                              width: 120,
                              decoration: const BoxDecoration(
                                color: btnColor,
                              ),
                            ),
                            const SizedBox(width: 15),
                            Container(
                              width: 120,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                              ),
                            ),
                            const SizedBox(width: 15),
                            Container(
                              width: 120,
                              decoration: const BoxDecoration(
                                color: btnColor,
                              ),
                            ),
                            const SizedBox(width: 15),
                            Container(
                              width: 120,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        bottom: 5.0,
                        left: 15.0,
                      ),
                      child: Text(
                        "All Genres",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 7, right: 10),
                      child: GridView(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 2.0,
                          crossAxisSpacing: 0,
                          childAspectRatio: MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 3),
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: btnColor,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.red,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: btnColor,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.red,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: btnColor,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
