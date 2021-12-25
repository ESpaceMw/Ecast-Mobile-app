import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecast/Models/channels.dart';
import 'package:ecast/Utils/constants.dart';
import 'package:flutter/material.dart';

class ViewChannel extends StatelessWidget {
  final Channels channelDetails;
  const ViewChannel({Key? key, required this.channelDetails}) : super(key: key);

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
                      child: const Icon(Icons.arrow_back)),
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
            // const SizedBox(
            //   height: 30,
            // ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.1,
              left: MediaQuery.of(context).size.width * 0.3,
              child: CachedNetworkImage(
                imageUrl: channelDetails.thumbnail,
                placeholder: (context, url) => const CircularProgressIndicator(
                  color: btnColor,
                ),
              ),
            ),
            Positioned(
                top: MediaQuery.of(context).size.height * 0.35,
                left: MediaQuery.of(context).size.width * 0.3,
                child: Text("E", style: textStyle))
          ],
        )
      ]),
    );
  }
}
