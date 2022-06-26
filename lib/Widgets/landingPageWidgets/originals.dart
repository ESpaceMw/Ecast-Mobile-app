import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecast/Screens/playlists_details.dart';
import 'package:ecast/Screens/view_podcasts.dart';
import 'package:ecast/Services/repos/repo.dart';
import 'package:ecast/Utils/constants.dart';
import 'package:ecast/cubit/podcasts_cubit.dart';
import 'package:ecast/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Originals extends StatelessWidget {
  const Originals(
      {Key? key, required this.state, required this.size, required this.repos})
      : super(key: key);

  final state;
  final Size size;
  final Repository repos;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 230,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: state.data.length,
          itemBuilder: (context, index) {
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
                width: 150,
                margin: const EdgeInsets.only(
                  // top: 10,
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
                        borderRadius: BorderRadius.circular(10),
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
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
