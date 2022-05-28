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
      body: Container(
        margin: const EdgeInsets.only(
          left: 15,
          right: 15,
        ),
        child: ListView(
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
                print(state.arts);
                return GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 2.0,
                    crossAxisSpacing: 0,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 1.3),
                  ),
                  itemCount: state.arts.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => BlocProvider.value(
                              value: PodcastsCubit(repository: repository),
                              child: ViewPodcast(details: state.arts[index]),
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
                                  imageUrl: state.arts[index]['cover_art'],
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
                              state.arts[index]['title'],
                              style: podstyles,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              state.arts[index]['author'],
                              style: TextStyle(color: Colors.grey[400]),
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
            })
          ],
        ),
      ),
    );
  }
}


// Container(
//                       // width: 30,
//                       height: 2000,
//                       margin: const EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                         color: recColor,
//                         borderRadius: BorderRadius.circular(18),
//                       ),
//                       child: Column(
//                         children: [
//                           Flexible(
//                             child: Padding(
//                               padding: const EdgeInsets.only(top: 13),
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(18),
//                                 child: CachedNetworkImage(
//                                   width:
//                                       MediaQuery.of(context).size.width * 0.37,
//                                   height:
//                                       MediaQuery.of(context).size.width * 0.37,
//                                   imageUrl: state.arts[index]['cover_art'],
//                                   placeholder: (context, url) => const Center(
//                                     child: CircularProgressIndicator(
//                                       color: btnColor,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(10.0),
//                             child: Text(
//                               state.arts[index]['title'],
//                               style: podstyles,
//                               textAlign: TextAlign.start,
//                             ),
//                           )
//                         ],
//                       ),
//                     ),