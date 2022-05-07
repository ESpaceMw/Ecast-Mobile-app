import 'package:ecast/Models/channels.dart';
import 'package:ecast/Screens/view_channel.dart';
import 'package:ecast/Screens/view_podcasts.dart';
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
  void initState() {
    super.initState();
  }

  // final ScrollController _scrollController = ScrollController();
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
                    (MediaQuery.of(context).size.height / 1.6),
              ),
              itemCount: state.subs.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BlocProvider.value(
                              value: PodcastsCubit(repository: repository),
                              child: ViewPodcast(details: state.subs[index]),
                            )));
                  },
                  child: Container(
                    // width: 30,
                    height: 2000,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: recColor,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 13),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: CachedNetworkImage(
                                width: MediaQuery.of(context).size.width * 0.37,
                                height:
                                    MediaQuery.of(context).size.width * 0.37,
                                imageUrl: state.subs[index]['cover_art'],
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(
                                  color: btnColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            state.subs[index]['title'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        )
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
