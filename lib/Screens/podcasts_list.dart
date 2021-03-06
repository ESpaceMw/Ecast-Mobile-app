import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecast/Screens/view_podcasts.dart';
import 'package:ecast/Services/api.dart';
import 'package:ecast/Services/repos/repo.dart';
import 'package:ecast/Utils/constants.dart';
import 'package:ecast/Widgets/components/indicator.dart';
import 'package:ecast/cubit/podcasts_cubit.dart';
import 'package:ecast/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final Repository repository = Repository(networkService: NetworkService());

class Podcasts extends StatelessWidget {
  const Podcasts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PodcastsCubit>(context).fetchPodcasts();
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
                      const Text("Recommended Podcasts", style: titleStyles)
                    ],
                  ),
                ]),
                itemExtent: 30,
              ),
              BlocBuilder<PodcastsCubit, PodcastsState>(
                builder: (context, state) {
                  if (state is Pod) {
                    if (state.arts.isEmpty) {
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
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => MultiBlocProvider(
                                    providers: [
                                      BlocProvider.value(
                                          value: PodcastsCubit(
                                              repository: repository)),
                                      BlocProvider.value(
                                        value:
                                            UserCubit(repository: repository),
                                      )
                                    ],
                                    child:
                                        ViewPodcast(details: state.arts[index]),
                                  ),
                                ));
                              },
                              child: Container(
                                width: 100,
                                margin: const EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 13),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                          imageUrl: state.arts[index]
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
                                      state.arts[index]['title'],
                                      style: podstyles,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      state.arts[index]['author'],
                                      style: TextStyle(color: Colors.grey[400]),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          childCount: state.arts.length,
                        ),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 2.0,
                          crossAxisSpacing: 0,
                          childAspectRatio: MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 1.5),
                        ),
                      );
                    }
                  } else {
                    return SliverFixedExtentList(
                      delegate: SliverChildListDelegate([
                        const Center(
                          child: CircularProgressIndicator(
                            color: btnColor,
                          ),
                        )
                      ]),
                      itemExtent: 100,
                    );
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
