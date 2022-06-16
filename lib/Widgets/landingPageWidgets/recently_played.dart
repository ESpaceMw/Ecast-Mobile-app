import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecast/Screens/view_podcasts.dart';
import 'package:ecast/Widgets/landing.dart';
import 'package:ecast/cubit/podcasts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecentlyPlayed extends StatelessWidget {
  const RecentlyPlayed({
    Key? key,
    required this.state,
  }) : super(key: key);

  final state;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: ListView.builder(
          itemCount: state.podcasts.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, index) {
            if (state.podcasts.isEmpty) {
              return const Text("No recent plays");
            } else {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BlocProvider.value(
                        value: PodcastsCubit(repository: repos),
                        child: ViewPodcast(
                          details: state.podcasts[index],
                        ),
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: state.podcasts[index]['cover_art'],
                    ),
                  ),
                ),
              );
            }
          }),
    );
  }
}
