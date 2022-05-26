import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecast/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PlaylistDetails extends StatelessWidget {
  final dynamic playlists;
  const PlaylistDetails({Key? key, required this.playlists}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const FaIcon(
                  FontAwesomeIcons.angleLeft,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Wrap(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                      10.0,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: playlists['cover_art'],
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        playlists['title'],
                        style: titleStyles,
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}