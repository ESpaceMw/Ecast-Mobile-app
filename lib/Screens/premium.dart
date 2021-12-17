import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecast/Models/channels.dart';
import 'package:ecast/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Premium extends StatefulWidget {
  const Premium({Key? key}) : super(key: key);

  @override
  _PremiumState createState() => _PremiumState();
}

class _PremiumState extends State<Premium> {
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

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        controller: _scrollController,
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back_ios),
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                'Premium',
                style: textStyle,
              )
            ],
          ),
          const SizedBox(height: 20),
          FutureBuilder<List<Channels>>(
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
          ),
        ],
      ),
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
            showModalBottomSheet(
                isScrollControlled: true,
                isDismissible: true,
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(40))),
                context: context,
                builder: (context) {
                  return Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      decoration: const BoxDecoration(
                          color: kBackgroundColor,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(40))),
                      child: ListView(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  top: 9,
                                  right: 6,
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: photos[index].thumbnail,
                                  width: 100,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                ),
                              ),
                              const Text(
                                "Title",
                                style: textStyle,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 9,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(photos[index].title),
                          ),
                        ],
                      ));
                });
          },
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
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
          ),
        );
      },
    );
  }
}
