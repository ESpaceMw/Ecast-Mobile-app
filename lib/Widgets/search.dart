import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecast/Screens/genres_list.dart';
import 'package:ecast/Screens/podcastcat.dart';
import 'package:ecast/Screens/podcasts_list.dart';
import 'package:ecast/Screens/view_podcasts.dart';
import 'package:ecast/Services/api.dart';
import 'package:ecast/Services/repos/repo.dart';
import 'package:ecast/Utils/constants.dart';
import 'package:ecast/Widgets/Errors/httpex.dart';
import 'package:ecast/Widgets/Errors/socketerr.dart';
import 'package:ecast/cubit/podcasts_cubit.dart';
import 'package:ecast/cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    BlocProvider.of<SearchCubit>(context).categories();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        // shrinkWrap: true,
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
                ),
                hintText: "Search",
                border: InputBorder.none,
              ),
              onFieldSubmitted: (String text) {
                if (text.isEmpty) {
                  BlocProvider.of<SearchCubit>(context).prev();
                } else {
                  recentlyPlayed.add(text);
                  BlocProvider.of<SearchCubit>(context).searchPodcast(text);
                }
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
              if (state is SearchMode) {
                return SafeArea(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 11, top: 2.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    FocusScope.of(context).unfocus();
                                    BlocProvider.of<SearchCubit>(context)
                                        .prev();
                                    _searchQuery.clear();
                                  },
                                  child: const Icon(
                                    Icons.arrow_back,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  'Recent Searches',
                                  style: info,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: recentlyPlayed.length,
                              itemBuilder: (context, index) {
                                if (recentlyPlayed.isEmpty) {
                                  return Container(
                                      child: const Text(
                                    "No recent searches",
                                    style: textStyle,
                                  ));
                                } else {
                                  return Container(
                                    child: ListTile(
                                      title: Text(recentlyPlayed[index]),
                                      trailing: GestureDetector(
                                        onTap: () {
                                          recentlyPlayed.removeAt(index);
                                        },
                                        child: const FaIcon(
                                            FontAwesomeIcons.xmark),
                                      ),
                                    ),
                                  );
                                }
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              } else if (state is Searching) {
                return Container(
                  height: size.height,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: btnColor,
                    ),
                  ),
                );
              } else if (state is SearchResults) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        BlocProvider.of<SearchCubit>(context).prev();
                        _searchQuery.clear();
                      },
                      child: const Icon(Icons.arrow_back),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.results.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => BlocProvider.value(
                                  value: PodcastsCubit(repository: repository),
                                  child: ViewPodcast(
                                      details: state.results[index]),
                                ),
                              ),
                            );
                          },
                          child: Container(
                              child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                  width:
                                      MediaQuery.of(context).size.width * 0.12,
                                  imageUrl: state.results[index]['cover_art']),
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.results[index]['title'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  state.results[index]['author'],
                                  style: const TextStyle(fontSize: 12),
                                )
                              ],
                            ),
                          )),
                        );
                      },
                    ),
                  ],
                );
              } else if (state is HttpErr) {
                return const HttpExc(msg: "Server Error! Contact System Admin");
              } else if (state is NetError) {
                return const SocketErr(
                    msg: "Network Error! Check your connection");
              } else {
                return ListView(
                  shrinkWrap: true,
                  children: [
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.of(context).push(
                    //       MaterialPageRoute(
                    //         builder: (context) => BlocProvider.value(
                    //             value: PodcastsCubit(repository: repository),
                    //             child: const Podcasts()),
                    //       ),
                    //     );
                    //   },
                    //   child: Container(
                    //     width: MediaQuery.of(context).size.width * 0.9,
                    //     height: 80,
                    //     margin: const EdgeInsets.only(left: 10, right: 10),
                    //     decoration: BoxDecoration(
                    //       color: btnColor,
                    //       borderRadius: BorderRadius.circular(10.0),
                    //     ),
                    //     child: const Center(
                    //       child: Text(
                    //         'All Podcasts',
                    //         style: textStyle,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 30,
                    // ),
                    // const Padding(
                    //   padding: EdgeInsets.only(
                    //     bottom: 5.0,
                    //     left: 15.0,
                    //   ),
                    //   child: Text(
                    //     "Your Top Genres",
                    //     style: TextStyle(
                    //       fontSize: 20,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 5,
                    ),
                    // Container(
                    //   height: 120,
                    //   margin: const EdgeInsets.only(left: 7, right: 10),
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: ListView(
                    //       scrollDirection: Axis.horizontal,
                    //       children: [
                    //         Container(
                    //           width: 120,
                    //           decoration: const BoxDecoration(
                    //             color: btnColor,
                    //           ),
                    //         ),
                    //         const SizedBox(width: 15),
                    //         Container(
                    //           width: 120,
                    //           decoration: const BoxDecoration(
                    //             color: Colors.red,
                    //           ),
                    //         ),
                    //         const SizedBox(width: 15),
                    //         Container(
                    //           width: 120,
                    //           decoration: const BoxDecoration(
                    //             color: btnColor,
                    //           ),
                    //         ),
                    //         const SizedBox(width: 15),
                    //         Container(
                    //           width: 120,
                    //           decoration: const BoxDecoration(
                    //             color: Colors.red,
                    //           ),
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 30,
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(
                        // bottom: 5.0,
                        left: 15.0,
                        right: 15.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            " Genres",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider.value(
                                    value: SearchCubit(repository: repository),
                                    child: const GenresList(),
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              'View All',
                              style: TextStyle(
                                color: btnColor,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    BlocConsumer<SearchCubit, SearchState>(
                      listener: (context, state) {
                        // TODO: implement listener
                      },
                      builder: (context, state) {
                        if (state is FetchedCat) {
                          return GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 2.0,
                              crossAxisSpacing: 0,
                            ),
                            itemCount: state.categories.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => BlocProvider.value(
                                        value:
                                            SearchCubit(repository: repository),
                                        child: FilterPodcasts(
                                          category: state.categories[index]
                                              ['name'],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(
                                    left: 15,
                                  ),
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 13),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: CachedNetworkImage(
                                            width: size.width * 0.4,
                                            imageUrl: state.categories[index]
                                                ['cover_art'],
                                            placeholder: (context, url) =>
                                                const Center(
                                              child: CircularProgressIndicator(
                                                color: btnColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: btnColor,
                            ),
                          );
                        }
                      },
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



// return Container(
                        //   margin: const EdgeInsets.only(left: 7, right: 10),
                        //   child: GridView(
                        //     shrinkWrap: true,
                        //     gridDelegate:
                        //         SliverGridDelegateWithFixedCrossAxisCount(
                        //       crossAxisCount: 2,
                        //       mainAxisSpacing: 2.0,
                        //       crossAxisSpacing: 0,
                        //       childAspectRatio:
                        //           MediaQuery.of(context).size.width /
                        //               (MediaQuery.of(context).size.height / 3),
                        //     ),
                        //     children: [
                        //       Padding(
                        //         padding: const EdgeInsets.all(8.0),
                        //         child: Container(
                        //           decoration: const BoxDecoration(
                        //             color: btnColor,
                        //           ),
                        //         ),
                        //       ),
                        //       Padding(
                        //         padding: const EdgeInsets.all(8.0),
                        //         child: Container(
                        //           decoration: const BoxDecoration(
                        //             color: Colors.red,
                        //           ),
                        //         ),
                        //       ),
                        //       Padding(
                        //         padding: const EdgeInsets.all(8.0),
                        //         child: Container(
                        //           decoration: const BoxDecoration(
                        //             color: btnColor,
                        //           ),
                        //         ),
                        //       ),
                        //       Padding(
                        //         padding: const EdgeInsets.all(8.0),
                        //         child: Container(
                        //           decoration: const BoxDecoration(
                        //             color: Colors.red,
                        //           ),
                        //         ),
                        //       ),
                        //       Padding(
                        //         padding: const EdgeInsets.all(8.0),
                        //         child: Container(
                        //           decoration: const BoxDecoration(
                        //             color: btnColor,
                        //           ),
                        //         ),
                        //       ),
                        //       Padding(
                        //         padding: const EdgeInsets.all(8.0),
                        //         child: Container(
                        //           decoration: const BoxDecoration(
                        //             color: Colors.red,
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // );
