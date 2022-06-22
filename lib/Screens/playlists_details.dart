import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecast/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marquee/marquee.dart';

class PlaylistDetails extends StatelessWidget {
  final dynamic playlists;
  const PlaylistDetails({Key? key, required this.playlists}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(playlists);
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          width: MediaQuery.of(context).size.width * 0.5,
                          imageUrl: playlists['cover_art'],
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(
                              color: btnColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: Text(
                        playlists['title'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListView.builder(
                  itemCount: playlists['episodes'].length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: Column(
                        children: [
                          ListTile(
                            leading: ClipRRect(
                              child: CachedNetworkImage(
                                width: MediaQuery.of(context).size.width * 0.1,
                                imageUrl: playlists['cover_art'],
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(
                                    color: btnColor,
                                  ),
                                ),
                              ),
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // Text(playlists['episodes'][index]['name'])
                                Container(
                                  height: 20,
                                  width:
                                      MediaQuery.of(context).size.width * 0.52,
                                  child: Marquee(
                                    startPadding: 10.0,
                                    blankSpace: 20.0,
                                    text: playlists['episodes'][index]['name'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                    scrollAxis: Axis.horizontal,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    velocity: 50.0,
                                    pauseAfterRound: const Duration(seconds: 1),
                                  ),
                                )
                              ],
                            ),
                            trailing: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () async {
                                  // SharedPreferences prefs =
                                  //     await SharedPreferences.getInstance();
                                  // recentlyPlayed.add(widget.details);
                                  // var data = convert.jsonEncode(recentlyPlayed);
                                  // prefs.setString("recent", data);
                                  // _audioManager.dispose();
                                  // _audioManager.init(
                                  //   state.episodes,
                                  //   index,
                                  //   widget.details['cover_art'],
                                  //   widget.details['author'],
                                  // );
                                  // _audioManager.play();
                                  // pushNewScreen(
                                  //   context,
                                  //   screen: MusicPlayer(
                                  //       img: widget.details['cover_art']),
                                  //   withNavBar: false,
                                  // );
                                },
                                child: const FaIcon(
                                  FontAwesomeIcons.circlePlay,
                                  size: 22,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 13),
                            child: Text(
                              playlists['episodes'][index]['description'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Divider(
                              height: 10,
                              thickness: 0.8,
                              color: Colors.grey.shade800,
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
