import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecast/Screens/player/music_player.dart';
import 'package:ecast/Screens/view_ep.dart';
import 'package:ecast/Services/api.dart';
import 'package:ecast/Services/repos/repo.dart';
import 'package:ecast/Utils/audioinstance.dart';
import 'package:ecast/Utils/constants.dart';
import 'package:ecast/cubit/podcasts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:marquee/marquee.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

final Repository repository = Repository(networkService: NetworkService());

class ViewPodcast extends StatefulWidget {
  final dynamic details;
  const ViewPodcast({Key? key, required this.details}) : super(key: key);

  @override
  State<ViewPodcast> createState() => _ViewPodcastState();
}

class _ViewPodcastState extends State<ViewPodcast> {
  late final AudioManager _audioManager;
  List music = [];
  List audio = [];

  @override
  void initState() {
    super.initState();
    _audioManager = AudioManager();
    print(music);
    music.clear();
    audio.clear();
    print(music);
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PodcastsCubit>(context).fetchEpisodes(widget.details['id']);
    return Scaffold(
      backgroundColor: Colors.black87,
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
                  blendMode: BlendMode.overlay,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.4,
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
              Positioned(
                top: MediaQuery.of(context).size.height * 0.1,
                left: MediaQuery.of(context).size.width * 0.25,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: CachedNetworkImage(
                    width: MediaQuery.of(context).size.width * 0.5,
                    imageUrl: widget.details['cover_art'],
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(
                      color: btnColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Text(
            widget.details['title'],
            style: titleStyles,
            textAlign: TextAlign.center,
          ),
          Text(
            widget.details['author'],
            style: const TextStyle(
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              widget.details['description'],
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: infostyle,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                          height: MediaQuery.of(context).size.height * 0.8,
                          decoration: const BoxDecoration(
                            color: kBackgroundColor,
                          ),
                          child: ListView(
                            children: const [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Podcast Feed",
                                  style: textStyle,
                                ),
                              )
                            ],
                          ));
                    },
                  );
                },
                child: const Icon(Icons.feed_sharp),
              ),
              const SizedBox(
                width: 20,
              ),
              BlocListener<PodcastsCubit, PodcastsState>(
                listener: (context, state) {
                  // if (state is PodCastsLoading) {
                  //   showDialog(
                  //       context: context,
                  //       builder: (context) {
                  //         return SimpleDialog(
                  //           children: [
                  //             Row(
                  //               children: const [
                  //                 Text('Please wait'),
                  //                 CircularProgressIndicator(),
                  //               ],
                  //             )
                  //           ],
                  //         );
                  //       });
                  // }

                  if (state is PodcastSubscripted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.msg)));
                  }
                },
                child: GestureDetector(
                  onTap: () {
                    BlocProvider.of<PodcastsCubit>(context)
                        .subscribe(widget.details['id'].toString());
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 35, right: 35, top: 5, bottom: 5),
                    decoration: BoxDecoration(
                      color: btnColor,
                      borderRadius: BorderRadius.circular(
                        20.8,
                      ),
                    ),
                    child: const Text(
                      "Subscribe",
                      style: TextStyle(
                        color: whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              GestureDetector(
                child: const Icon(Icons.share),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 8, 10, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'All episodes',
                  style: extreStyles,
                ),
                GestureDetector(
                  onTap: () async {
                    if (music.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please wait for the episodes to load'),
                        ),
                      );
                    } else {
                      _audioManager.dispose();
                      _audioManager.init(
                        music[0],
                        0,
                        widget.details['cover_art'],
                        widget.details['author'],
                      );
                      _audioManager.play();
                      pushNewScreen(
                        context,
                        screen: MusicPlayer(img: widget.details['cover_art']),
                        withNavBar: false,
                      );
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 5.0,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: whiteColor,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(
                        20.0,
                      ),
                    ),
                    child: const Text('Play All'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          BlocBuilder<PodcastsCubit, PodcastsState>(
            builder: (context, state) {
              if (state is FetchedEpisodes) {
                music.add(state.episodes);
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: state.episodes.length,
                  itemBuilder: (context, index) {
                    var date = DateFormat.yMMMd()
                        .format(DateTime.parse(
                            state.episodes[index]['uploaded_date']))
                        .toString();
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => BlocProvider.value(
                              value: PodcastsCubit(repository: repository),
                              child: ViewEp(
                                ep: state.episodes[index],
                                cover: widget.details['cover_art'],
                                author: widget.details['author'],
                                title: widget.details['title'],
                              ),
                            ),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                6.5,
                              ),
                              child: CachedNetworkImage(
                                width: MediaQuery.of(context).size.width * 0.1,
                                imageUrl: widget.details['cover_art'],
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(
                                  color: btnColor,
                                ),
                              ),
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        height: 20,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.52,
                                        child: Marquee(
                                          startPadding: 10.0,
                                          blankSpace: 20.0,
                                          text: state.episodes[index]['name'],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                          ),
                                          scrollAxis: Axis.horizontal,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          velocity: 50.0,
                                          pauseAfterRound:
                                              const Duration(seconds: 1),
                                        )),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      date,
                                      style: const TextStyle(
                                        fontSize: 10,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                const Flexible(
                                  child: FaIcon(
                                    FontAwesomeIcons.circleArrowDown,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                              ],
                            ),
                            trailing: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  if (audio.isEmpty) {
                                    audio.add(state.episodes[index]);
                                  }
                                  audio.clear();
                                  audio.add(state.episodes[index]);
                                  _audioManager.dispose();
                                  _audioManager.init(
                                    audio,
                                    0,
                                    widget.details['cover_art'],
                                    widget.details['author'],
                                  );
                                  _audioManager.play();
                                  pushNewScreen(
                                    context,
                                    screen: MusicPlayer(
                                        img: widget.details['cover_art']),
                                    withNavBar: false,
                                  );
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
                              state.episodes[index]['description'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
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
                  },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    color: btnColor,
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
