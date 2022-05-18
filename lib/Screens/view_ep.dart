import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecast/Screens/player/music_player.dart';
import 'package:ecast/Utils/audioinstance.dart';
import 'package:ecast/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class ViewEp extends StatefulWidget {
  final dynamic ep;
  final String cover;
  final String author;
  final String title;
  const ViewEp({
    Key? key,
    required this.ep,
    required this.cover,
    required this.author,
    required this.title,
  }) : super(key: key);

  @override
  State<ViewEp> createState() => _ViewEpState();
}

class _ViewEpState extends State<ViewEp> {
  late final AudioManager _audioManager;
  List data = [];
  final index = 0;

  @override
  void initState() {
    super.initState();
    _audioManager = AudioManager();
    data.add(widget.ep);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5.5),
                    bottomRight: Radius.circular(5.5),
                  ),
                ),
                child: ShaderMask(
                  shaderCallback: (rect) => const LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.center,
                    colors: [
                      Colors.black87,
                      kBackgroundColor,
                    ],
                  ).createShader(rect),
                  blendMode: BlendMode.darken,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/img_7.jpg'),
                        fit: BoxFit.cover,
                        colorFilter:
                            ColorFilter.mode(Colors.black45, BlendMode.lighten),
                      ),
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
                  ],
                ),
              ),
              Wrap(
                // direction: Axis.vertical,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              width: MediaQuery.of(context).size.width * 0.4,
                              imageUrl: widget.cover,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(
                                color: btnColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15.0,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.ep['name'],
                                style: titleStyles,
                                textAlign: TextAlign.start,
                              ),
                              Text(
                                widget.title,
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                widget.author,
                                style: const TextStyle(
                                  color: btnColor,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    _audioManager.dispose();
                    _audioManager.init(
                      data,
                      index,
                      widget.cover,
                      widget.author,
                    );
                    _audioManager.play();
                    setState(() {
                      playing = true;
                    });
                    pushNewScreen(
                      context,
                      screen: MusicPlayer(
                        img: widget.cover,
                      ),
                      withNavBar: false,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: btnColor,
                      borderRadius: BorderRadius.circular(
                        30.0,
                      ),
                    ),
                    child: const Text(
                      'Play',
                      style: textStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Row(
                  children: const [
                    Icon(
                      Icons.playlist_add,
                      size: 30,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    FaIcon(
                      FontAwesomeIcons.circleArrowDown,
                      // size: 20,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.share,
                      size: 26,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
            ),
            child: Text(
              widget.ep['description'],
              style: const TextStyle(
                  // color: Colors.grey,
                  ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: 20,
            ),
            child: Text(
              'You May Also Like',
              style: textStyle,
            ),
          )
        ],
      ),
    );
  }
}
