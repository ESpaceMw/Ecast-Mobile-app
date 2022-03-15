import 'dart:io';

import 'package:ecast/Models/channels.dart';
import 'package:ecast/Screens/view_channel.dart';
import 'package:ecast/Utils/constants.dart';
import 'package:ecast/cubit/podcasts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Subscriptions extends StatefulWidget {
  const Subscriptions({Key? key}) : super(key: key);

  @override
  _SubscriptionsState createState() => _SubscriptionsState();
}

class _SubscriptionsState extends State<Subscriptions> {
  // List<Channels> parsePhotos(String responseBody) {
  //   final parsed =
  //       convert.jsonDecode(responseBody).cast<Map<String, dynamic>>();
  //   return parsed.map<Channels>((json) => Channels.fromJson(json)).toList();
  // }

  // Future<List<Channels>> _getChannels() async {
  //   var url = 'https://jsonplaceholder.typicode.com/photos/?_limit=16';
  //   var response = await http.get(Uri.parse(url));
  //   var jsonData = convert.jsonDecode(response.body);
  //   return parsePhotos(response.body);
  // }

  @override
  void initState() {
    // _getChannels();
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
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(
                  color: btnColor,
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Fetching Your Subscriptions"),
              ],
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
        mainAxisSpacing: 4.0,
      ),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    ViewChannel(channelDetails: photos[index])));
          },
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            color: recColor,
            child: Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Flexible(
                      child: Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 9),
                    child: CachedNetworkImage(
                      imageUrl: photos[index].thumbnail,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(
                        color: btnColor,
                      ),
                    ),
                  )),
                  const Text('Title')
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
