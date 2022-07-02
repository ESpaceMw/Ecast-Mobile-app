import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecast/Screens/view_podcasts.dart';
import 'package:ecast/Services/repos/repo.dart';
import 'package:ecast/Utils/constants.dart';
import 'package:ecast/cubit/podcasts_cubit.dart';
import 'package:ecast/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Recommended extends StatelessWidget {
  const Recommended(
      {Key? key, required this.state, required this.size, required this.repos})
      : super(key: key);

  final state;
  final Size size;
  final Repository repos;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 250,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          itemBuilder: (context, index) {
            // print(state.data[index]);
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MultiBlocProvider(
                    providers: [
                      BlocProvider.value(
                          value: PodcastsCubit(repository: repos)),
                      BlocProvider.value(
                        value: UserCubit(repository: repos),
                      )
                    ],
                    child: ViewPodcast(details: state.data[index]),
                  ),
                ));
              },
              child: Container(
                width: 160,
                margin: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  left: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 13),
                      child: ClipRRect(
                        child: CachedNetworkImage(
                          width: size.width * 0.39,
                          imageUrl: state.data[index]['cover_art'],
                          placeholder: (context, url) => const Center(
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
                      state.data[index]['title'],
                      style: podstyles,
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      state.data[index]['author'],
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
