import 'package:ecast/Models/channels.dart';
import 'package:ecast/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Subscriptions extends StatefulWidget {
  const Subscriptions({Key? key}) : super(key: key);

  @override
  _SubscriptionsState createState() => _SubscriptionsState();
}

class _SubscriptionsState extends State<Subscriptions> {
  List<Channels> parsePhotos(String responseBody) {
    final parsed =
        convert.jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Channels>((json) => Channels.fromJson(json)).toList();
  }

  Future<List<Channels>> _getChannels() async {
    var url = 'https://jsonplaceholder.typicode.com/photos/?_limit=16';
    var response = await http.get(Uri.parse(url));
    var jsonData = convert.jsonDecode(response.body);
    return parsePhotos(response.body);
  }

  @override
  void initState() {
    _getChannels();
    super.initState();
  }

  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Channels>>(
      future: _getChannels(),
      builder: (context, snapshot) {
        // ignore: unused_local_variable
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const Center(
              child: Text("Fetch somethin"),
            );

          case ConnectionState.active:
          case ConnectionState.waiting:
            return Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );

          case ConnectionState.done:
            if (snapshot.hasError) {
              return const Center(
                child: Text("Ooops, something went wrong"),
              );
            } else {
              if (snapshot.data != []) {
                return ChannelsList(photos: snapshot.data!);
              } else {
                return const Center(
                  child: Text("No subscriptions"),
                );
              }
            }
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
        return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          color: Colors.blueGrey[900],
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
        );
      },
    );
  }
}
