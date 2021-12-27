import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecast/Models/channels.dart';
import 'package:ecast/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:shared_preferences/shared_preferences.dart';

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
                          Column(
                            children: const [
                              Text("Impact goals", style: textStyle),
                              Text("Season 1"),
                              Text("data")
                            ],
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
                      const SizedBox(
                        height: 9,
                      ),
                      GestureDetector(
                        onTap: () {
                          subScribe(context, photos[index].id);
                        },
                        child: Container(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 8, bottom: 8),
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(
                                10.8,
                              ),
                            ),
                            child: const Text(
                              "Subscribe and Listen",
                              style: TextStyle(
                                color: whiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            )),
                      ),
                    ],
                  ),
                );
              },
            );
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

  Future subScribe(context, id) async {
    var url = 'http://10.0.2.2:8000/api/v1/subscription/unsubscribe';
    var alerts = 'http://10.0.2.2:8000/api/v1/alerts/create';

    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map userMap = convert.jsonDecode(prefs.getString("user").toString());
    // Dialogs.showLoadingDialog(context, keyLoader);

    try {
      var response = await http.post(Uri.parse(url),
          body: {'user_id': userMap['id'], 'channels_id': id});
      var info = convert.jsonDecode(response.body);

      if (response.statusCode == 200 &&
          info['message'] != 'You are already subscribed to this channel') {
        await http.post(Uri.parse(alerts), body: {
          'user_id': userMap['id'],
          'title': "Subscription",
          'content': "Subscribed to channel",
          'type': "daata"
        });
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "subscribed successfully",
              textAlign: TextAlign.center,
              style: snackBarText,
            ),
            backgroundColor: btnColor,
            elevation: 17,
          ),
        );

        Navigator.pop(context);
      } else {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "You are already subscribed to this channel",
              textAlign: TextAlign.center,
              style: snackBarText,
            ),
            backgroundColor: errorColor,
            elevation: 17,
          ),
        );
      }
    } on SocketException {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Oops! No internet connection",
            textAlign: TextAlign.center,
            style: snackBarText,
          ),
          backgroundColor: errorColor,
          elevation: 17,
        ),
      );
    } on HttpException {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Server error, contact administrator",
            textAlign: TextAlign.center,
            style: snackBarText,
          ),
          backgroundColor: errorColor,
          elevation: 17,
        ),
      );
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Something went wrong",
            textAlign: TextAlign.center,
            style: snackBarText,
          ),
          backgroundColor: errorColor,
          elevation: 17,
        ),
      );
    }
  }
}
