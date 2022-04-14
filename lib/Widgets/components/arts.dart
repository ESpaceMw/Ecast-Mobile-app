import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecast/Screens/view_channel.dart';
import 'package:ecast/Utils/constants.dart';
import 'package:ecast/cubit/podcasts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Arts extends StatelessWidget {
  const Arts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PodcastsCubit>(context).arts();
    return BlocBuilder<PodcastsCubit, PodcastsState>(
      builder: (context, state) {
        if (state is Pod) {
          return GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 4.0,
            ),
            itemCount: state.arts.length,
            itemBuilder: (context, index) {
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ViewChannel(
                          channelDetails: state.arts[index],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 16,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: recColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      children: [
                        Flexible(
                            child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: CachedNetworkImage(
                              imageUrl: state.arts[index]['cover_art'],
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(
                                color: btnColor,
                              ),
                            ),
                          ),
                        )),
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            state.arts[index]['title'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              // fontSize: 16,
                            ),
                          ),
                        )
                      ],
                    ),
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
        // return Center(
        //   child: Text("Arts"),
        // );
      },
    );
  }
}
