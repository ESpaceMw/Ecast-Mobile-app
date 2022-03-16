import 'package:ecast/Models/channels.dart';
import 'package:ecast/Screens/view_channel.dart';
import 'package:ecast/Utils/constants.dart';
import 'package:ecast/cubit/podcasts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          return ChannelsList(photos: state.subs);
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

class ChannelsList extends StatelessWidget {
  const ChannelsList({Key? key, required this.photos}) : super(key: key);

  final List<Channels> photos;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10.0,
      ),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ViewChannel(
                  channelDetails: photos[index],
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
                const SizedBox(
                  height: 10,
                ),
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: photos[index].thumbnail,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(
                          color: btnColor,
                        ),
                      ),
                      width: 130,
                      height: 130,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('Title')
              ],
            ),
          ),
        );
      },
    );
  }
}
