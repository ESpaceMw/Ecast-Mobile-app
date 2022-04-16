import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecast/Screens/view_podcasts.dart';
import 'package:ecast/Services/api.dart';
import 'package:ecast/Services/repos/repo.dart';
import 'package:ecast/Utils/constants.dart';
import 'package:ecast/cubit/podcasts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final Repository repository = Repository(networkService: NetworkService());

class Podcasts extends StatelessWidget {
  const Podcasts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PodcastsCubit>(context).fetchPodcasts();
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back_ios),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'Podcasts Available',
                  style: textStyle,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          BlocConsumer<PodcastsCubit, PodcastsState>(
              listener: (context, state) {
            // TODO: implement listener
          }, builder: (context, state) {
            if (state is Pod) {
              return GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 4.0,
                ),
                itemCount: state.arts.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BlocProvider.value(
                                value: PodcastsCubit(repository: repository),
                                child: ViewPodcast(details: state.arts[index]),
                              )));
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
          })
        ],
      ),
    );
  }
}
