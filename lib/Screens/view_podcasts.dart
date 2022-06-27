import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecast/Screens/player/music_player.dart';
import 'package:ecast/Screens/view_ep.dart';
import 'package:ecast/Services/api.dart';
import 'package:ecast/Services/repos/repo.dart';
import 'package:ecast/Utils/audioinstance.dart';
import 'package:ecast/Utils/constants.dart';
import 'package:ecast/cubit/charts_cubit.dart';
import 'package:ecast/cubit/podcasts_cubit.dart';
import 'package:ecast/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:marquee/marquee.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

final Repository repository = Repository(networkService: NetworkService());

class ViewPodcast extends StatefulWidget {
  final dynamic details;
  const ViewPodcast({Key? key, required this.details}) : super(key: key);

  @override
  State<ViewPodcast> createState() => _ViewPodcastState();
}

class _ViewPodcastState extends State<ViewPodcast> {
  late final AudioManager _audioManager;
  List audio = [];

  @override
  void initState() {
    super.initState();
    _audioManager = AudioManager();
    audio.clear();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserCubit>(context).showFollowing(widget.details['id']);

    BlocProvider.of<PodcastsCubit>(context).fetchEpisodes(widget.details['id']);
    final size = MediaQuery.of(context).size;
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
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.34,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.details['header_image']),
                      fit: BoxFit.cover,
                      colorFilter: const ColorFilter.mode(
                          Colors.black45, BlendMode.darken),
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
                        onTap: () {
                          Navigator.pop(context);
                          BlocProvider.of<PodcastsCubit>(context)
                              .fetchPodcasts();
                        },
                        child: const Icon(Icons.arrow_back),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.08,
                left: MediaQuery.of(context).size.width * 0.25,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: CachedNetworkImage(
                    width: MediaQuery.of(context).size.width * 0.5,
                    imageUrl: widget.details['cover_art'],
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(
                        color: btnColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(10.0), right: Radius.circular(10.0)),
              ),
              child: Column(
                children: [
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
                        child: const FaIcon(FontAwesomeIcons.circleInfo),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.8,
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
                      BlocConsumer<UserCubit, UserState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          if (state is Followed) {
                            if (state.following) {
                              return BlocListener<PodcastsCubit, PodcastsState>(
                                listener: (context, state) {
                                  if (state is SubProcess) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        backgroundColor: Colors.black45,
                                        duration: Duration(
                                          milliseconds: 30,
                                        ),
                                        content: Text(
                                          'Perfoming Operation! Please wait....',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: whiteColor,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  if (state is Unsubscribed) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(state.msg)));
                                    Navigator.pop(context);
                                  }
                                },
                                child: GestureDetector(
                                  onTap: () =>
                                      BlocProvider.of<PodcastsCubit>(context)
                                          .unsubscribe(
                                              widget.details['id'].toString()),
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
                                      "Subscribed",
                                      style: TextStyle(
                                        color: whiteColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return BlocListener<PodcastsCubit, PodcastsState>(
                                listener: (context, state) {
                                  if (state is SubProcess) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        duration: Duration(
                                          milliseconds: 30,
                                        ),
                                        backgroundColor: Colors.black45,
                                        content: Text(
                                          'Perfoming Operation! Please wait....',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: whiteColor,
                                          ),
                                        ),
                                      ),
                                    );
                                  }

                                  if (state is PodcastSubscripted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(state.msg)));
                                    // Navigator.pop(context);
                                    Navigator.pop(context);
                                  }
                                },
                                child: GestureDetector(
                                  onTap: () =>
                                      BlocProvider.of<PodcastsCubit>(context)
                                          .subscribe(
                                              widget.details['id'].toString()),
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
                              );
                            }
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: btnColor,
                              ),
                            );
                          }
                        },
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (BuildContext context) {
                                return ClipRRect(
                                  borderRadius: const BorderRadius.horizontal(
                                    left: Radius.circular(10.0),
                                    right: Radius.circular(10.0),
                                  ),
                                  child: Container(
                                    height: size.height * 0.34,
                                    decoration: BoxDecoration(
                                        color: scaffoldColor,
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black54.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                          )
                                        ]),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: ListView(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 130.0,
                                            ),
                                            child: Divider(
                                                color: Colors.grey,
                                                height: 10,
                                                thickness: 2),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          const Text(
                                            "SUPPORT THE AUTHOR",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.grey[700],
                                              borderRadius:
                                                  BorderRadius.circular(
                                                10.0,
                                              ),
                                            ),
                                            width: size.width * 0.9,
                                            padding: const EdgeInsets.all(10.0),
                                            child: const Text(
                                              "TNM MPAMBA",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 17,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.grey[700],
                                              borderRadius:
                                                  BorderRadius.circular(
                                                10.0,
                                              ),
                                            ),
                                            width: size.width * 0.9,
                                            padding: const EdgeInsets.all(10.0),
                                            child: const Text(
                                              "AIRTEL MONEY",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 17,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.grey[700],
                                              borderRadius:
                                                  BorderRadius.circular(
                                                10.0,
                                              ),
                                            ),
                                            width: size.width * 0.9,
                                            padding: const EdgeInsets.all(10.0),
                                            child: const Text(
                                              "MO 626",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 17,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.grey[700],
                                              borderRadius:
                                                  BorderRadius.circular(
                                                10.0,
                                              ),
                                            ),
                                            width: size.width * 0.9,
                                            padding: const EdgeInsets.all(10.0),
                                            child: const Text(
                                              "PAYPAL",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 17,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                        child: const FaIcon(
                          FontAwesomeIcons.handHoldingDollar,
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
                  const Padding(
                    padding: EdgeInsets.fromLTRB(18, 8, 10, 10),
                    child: Text(
                      'All episodes',
                      style: extreStyles,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  BlocBuilder<PodcastsCubit, PodcastsState>(
                    builder: (context, state) {
                      if (state is FetchedEpisodes) {
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
                                // print(widget.details);
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => BlocProvider.value(
                                      value:
                                          PodcastsCubit(repository: repository),
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.1,
                                        imageUrl: widget.details['cover_art'],
                                        placeholder: (context, url) =>
                                            const CircularProgressIndicator(
                                          color: btnColor,
                                        ),
                                      ),
                                    ),
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                height: 20,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.52,
                                                child: Marquee(
                                                  startPadding: 10.0,
                                                  blankSpace: 20.0,
                                                  text: state.episodes[index]
                                                      ['name'],
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13,
                                                  ),
                                                  scrollAxis: Axis.horizontal,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  velocity: 50.0,
                                                  pauseAfterRound:
                                                      const Duration(
                                                          seconds: 1),
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
                                        onTap: () async {
                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          recentlyPlayed.add(widget.details);
                                          var data = convert
                                              .jsonEncode(recentlyPlayed);
                                          prefs.setString("recent", data);
                                          _audioManager.dispose();
                                          _audioManager.init(
                                            state.episodes,
                                            index,
                                            widget.details['cover_art'],
                                            widget.details['author'],
                                          );
                                          pushNewScreen(
                                            context,
                                            screen: BlocProvider.value(
                                              value: ChartsCubit(
                                                  repository: repository),
                                              child: MusicPlayer(
                                                  img: widget
                                                      .details['cover_art']),
                                            ),
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
              )),
        ],
      ),
    );
  }
}
