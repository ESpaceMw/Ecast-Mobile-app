import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecast/Screens/playlists_details.dart';
import 'package:ecast/Utils/constants.dart';
import 'package:flutter/material.dart';

class EcastPlaylist extends StatelessWidget {
  const EcastPlaylist({
    Key? key,
    required this.state,
    required this.size,
  }) : super(key: key);

  final state;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 230,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PlaylistDetails(
                      playlists: state.playlists[index],
                    ),
                  ),
                );
              },
              child: Container(
                width: 150,
                margin: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  left: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 13),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          width: size.width * 0.39,
                          imageUrl: state.playlists[index]['cover_art'],
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(
                              color: btnColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(
                      state.playlists[index]['title'],
                      style: podstyles,
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
