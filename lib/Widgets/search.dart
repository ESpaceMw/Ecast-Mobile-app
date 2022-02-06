import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecast/Models/channels.dart';
import 'package:ecast/Screens/view_channel.dart';
import 'package:ecast/Utils/constants.dart';
import 'package:ecast/Utils/logic.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final ScrollController _Controller = ScrollController();
  final TextEditingController _searchQuery = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      controller: _Controller,
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          margin: const EdgeInsets.only(left: 10, right: 10),
          decoration: const BoxDecoration(
            color: codeColor,
            borderRadius: BorderRadius.all(
              Radius.circular(
                10.8,
              ),
            ),
          ),
          child: TextFormField(
            controller: _searchQuery,
            decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.search_rounded,
              ),
              hintText: "Search",
              border: InputBorder.none,
            ),
            onFieldSubmitted: searchData,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Genres",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Genres(),
      ],
    );
  }
}

class Genres extends StatefulWidget {
  const Genres({Key? key}) : super(key: key);

  @override
  _GenresState createState() => _GenresState();
}

class _GenresState extends State<Genres> {
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
    super.initState();
    _getChannels();
  }

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
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    ViewChannel(channelDetails: photos[index])));
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
