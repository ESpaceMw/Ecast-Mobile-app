import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecast/Models/channels.dart';
import 'package:ecast/Utils/constants.dart';
import 'package:ecast/Utils/loader.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:shared_preferences/shared_preferences.dart';

class ViewChannel extends StatefulWidget {
  final Channels channelDetails;
  const ViewChannel({Key? key, required this.channelDetails}) : super(key: key);

  @override
  State<ViewChannel> createState() => _ViewChannelState();
}

class _ViewChannelState extends State<ViewChannel> {
  Future getEpisodes() async {}
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEpisodes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        Stack(
          children: [
            ShaderMask(
              shaderCallback: (rect) => const LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black87,
                  kBackgroundColor,
                ],
              ).createShader(rect),
              blendMode: BlendMode.darken,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/img_7.jpg'),
                    fit: BoxFit.cover,
                    colorFilter:
                        ColorFilter.mode(Colors.black45, BlendMode.darken),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      top: 10,
                    ),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 10,
                    ),
                    child: const Icon(
                      Icons.menu_book_sharp,
                      size: 30,
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.1,
              left: MediaQuery.of(context).size.width * 0.3,
              child: CachedNetworkImage(
                imageUrl: widget.channelDetails.thumbnail,
                placeholder: (context, url) => const CircularProgressIndicator(
                  color: btnColor,
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.35,
              left: MediaQuery.of(context).size.width * 0.27,
              child: const Text(
                "Engaging Influencers",
                style: textStyle,
                textAlign: TextAlign.center,
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.4,
              left: MediaQuery.of(context).size.width * 0.38,
              child: const Text(
                "Nhlanhla Dhaka",
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.43,
              left: MediaQuery.of(context).size.width * 0.08,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(widget.channelDetails.title),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.5,
              left: MediaQuery.of(context).size.width * 0.3,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "153 listeners",
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "130 episodes",
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                top: MediaQuery.of(context).size.height * 0.55,
                left: MediaQuery.of(context).size.width * 0.3,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.bookmark_outline),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        subScribe(context);
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
                            "UnSubscribe",
                            style: TextStyle(
                              color: whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          )),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.share)
                  ],
                )),
          ],
        )
      ]),
    );
  }

  Future subScribe(context) async {
    var url = 'http://10.0.2.2:8000/api/v1/subscription/unsubscribe';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map userMap = convert.jsonDecode(prefs.getString("user").toString());
    // Dialogs.showLoadingDialog(context, keyLoader);

    try {
      var response = await http.post(Uri.parse(url), body: {
        'user_id': userMap['id'],
        'channels_id': widget.channelDetails.id,
      });
      if (response.statusCode == 200) {
        var data = convert.jsonDecode(response.body);
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Unsubscribed successfully",
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
              "Something went wrong",
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
