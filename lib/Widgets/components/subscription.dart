import 'package:ecast/Screens/view_podcasts.dart';
import 'package:ecast/Screens/view_subs.dart';
import 'package:ecast/Services/api.dart';
import 'package:ecast/Services/repos/repo.dart';
import 'package:ecast/Utils/constants.dart';
import 'package:ecast/cubit/podcasts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Repository repository = Repository(networkService: NetworkService());

class Subscriptions extends StatefulWidget {
  const Subscriptions({Key? key}) : super(key: key);

  @override
  _SubscriptionsState createState() => _SubscriptionsState();
}

class _SubscriptionsState extends State<Subscriptions> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PodcastsCubit>(context).subScription();

    return BlocConsumer<PodcastsCubit, PodcastsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is PodcastsLoaded) {
          if (state.subs.isEmpty) {
            // ignore: sized_box_for_whitespace
            return Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: const Center(
                    child: Text(
                  "No subscriptions available",
                  style: textStyle,
                )));
          } else {
            return GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 2.0,
                crossAxisSpacing: 0,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.3),
              ),
              itemCount: state.subs.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BlocProvider.value(
                              value: PodcastsCubit(repository: repository),
                              child: Subs(details: state.subs[index]),
                            )));
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
                              imageUrl: 'http://10.0.2.2:8080' +
                                  state.subs[index]['cover_art'],
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
                          state.subs[index]['title'],
                          style: podstyles,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          state.subs[index]['author'],
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        } else {
          return Container(
            height: MediaQuery.of(context).size.height * 0.76,
            child: const Center(
              child: CircularProgressIndicator(
                color: btnColor,
              ),
            ),
          );
        }
      },
    );
  }
}
