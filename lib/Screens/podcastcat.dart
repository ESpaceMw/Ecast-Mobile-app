import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecast/Screens/view_podcasts.dart';
import 'package:ecast/Services/api.dart';
import 'package:ecast/Services/repos/repo.dart';
import 'package:ecast/Utils/constants.dart';
import 'package:ecast/Widgets/Errors/httpex.dart';
import 'package:ecast/Widgets/Errors/socketerr.dart';
import 'package:ecast/Widgets/components/indicator.dart';
import 'package:ecast/cubit/podcasts_cubit.dart';
import 'package:ecast/cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Repository repo = Repository(networkService: NetworkService());

class FilterPodcasts extends StatelessWidget {
  final String category;
  const FilterPodcasts({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SearchCubit>(context).filterPodcasts(category);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: CustomScrollView(
            slivers: [
              SliverFixedExtentList(
                delegate: SliverChildListDelegate([
                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const FaIcon(FontAwesomeIcons.angleLeft),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(category, style: titleStyles)
                    ],
                  ),
                ]),
                itemExtent: 30,
              ),
              BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is FetchedCat) {
                    if (state.categories.isEmpty) {
                      return SliverFixedExtentList(
                        delegate: SliverChildListDelegate([
                          Container(
                            height: MediaQuery.of(context).size.height * 0.8,
                            child: const Center(
                              child: Text(
                                'No Podcasts in this category',
                                style: textStyle,
                              ),
                            ),
                          )
                        ]),
                        itemExtent: 1,
                      );
                    } else {
                      return SliverGrid(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => BlocProvider.value(
                                      value: PodcastsCubit(repository: repo),
                                      child: ViewPodcast(
                                          details: state.categories[index]),
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: 200,
                                margin: const EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 13),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
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
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    Text(
                                      state.categories[index]['title'],
                                      style: podstyles,
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      state.categories[index]['author'],
                                      style: TextStyle(color: Colors.grey[400]),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          childCount: state.categories.length,
                        ),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 2.0,
                          crossAxisSpacing: 0,
                          childAspectRatio: MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 1.3),
                        ),
                      );
                    }
                  } else {
                    if (state is NetError) {
                      return SliverFixedExtentList(
                        delegate: SliverChildListDelegate([
                          const SocketErr(
                              msg: "Network Error! Check your connection")
                        ]),
                        itemExtent: 2,
                      );
                    } else if (state is HttpErr) {
                      return SliverFixedExtentList(
                        delegate: SliverChildListDelegate([
                          const HttpExc(
                              msg: "Server Error! COntact System admin")
                        ]),
                        itemExtent: 2,
                      );
                    } else {
                      return const CirculaIndicator();
                    }
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
