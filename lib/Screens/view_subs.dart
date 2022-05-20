import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecast/Screens/player/music_player.dart';
import 'package:ecast/Screens/view_ep.dart';
import 'package:ecast/Utils/audioinstance.dart';
import 'package:ecast/Utils/constants.dart';
import 'package:ecast/cubit/podcasts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:marquee/marquee.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class Subs extends StatefulWidget {
  final dynamic details;
  const Subs({Key? key, required this.details}) : super(key: key);

  @override
  State<Subs> createState() => _SubsState();
}

class _SubsState extends State<Subs> {
  late final AudioManager _audioManager;
  @override
  void initState() {
    super.initState();
    _audioManager = AudioManager();
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
                    imageUrl:
                        'http://10.0.2.2:8080' + widget.details['cover_art'],
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
              color: Colors.blue,
            ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.details['description'],
              style: infostyle,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                child: const Icon(Icons.feed_sharp),
              ),
              const SizedBox(
                width: 20,
              ),
              BlocListener<PodcastsCubit, PodcastsState>(
                listener: (context, state) {
                  if (state is SubProcess) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return SimpleDialog(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    CircularProgressIndicator(),
                                    Text('Please wait'),
                                  ],
                                ),
                              )
                            ],
                          );
                        });
                  }

                  if (state is Unsubscribed) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.msg)));
                  }
                },
                child: GestureDetector(
                  onTap: () {
                    BlocProvider.of<PodcastsCubit>(context)
                        .unsubscribe(widget.details['id'].toString());
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 35, right: 35, top: 8, bottom: 8),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(
                        20.8,
                      ),
                    ),
                    child: const Text(
                      "UnSubscribe",
                      style: TextStyle(
                        color: whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              const Icon(Icons.share)
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
            height: 20,
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
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => BlocProvider.value(
                                value: PodcastsCubit(repository: repository),
                                child: ViewEp(
                                  ep: state.episodes[index],
                                  cover: 'http://10.0.2.2:8080' +
                                      widget.details['cover_art'],
                                  author: widget.details['author'],
                                  title: widget.details['title'],
                                ),
                              ),
                            ));
                          },
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                6.5,
                              ),
                              child: CachedNetworkImage(
                                width: MediaQuery.of(context).size.width * 0.1,
                                imageUrl: 'http://10.0.2.2:8080' +
                                    widget.details['cover_art'],
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
                                                0.5,
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
                                          // numberOfRounds: 3,
                                        )),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      'Published on $date',
                                      style: const TextStyle(
                                        fontSize: 10,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                const Flexible(child: Icon(Icons.download)),
                                const SizedBox(
                                  width: 15,
                                ),
                                // SingleChildScrollView(
                                //   scrollDirection: Axis.horizontal,
                                //   child: Text(
                                //     state.episodes[index]['runtime'],
                                //     style: const TextStyle(
                                //       fontSize: 11,
                                //       color: Colors.grey,
                                //     ),
                                //   ),
                                // )
                              ],
                            ),
                            trailing: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  _audioManager.init(
                                      state.episodes,
                                      index,
                                      'http://10.0.2.2:8080' +
                                          widget.details['cover_art'],
                                      widget.details['author']);
                                  pushNewScreen(
                                    context,
                                    screen: MusicPlayer(
                                        img: widget.details['cover_art']),
                                    withNavBar: false,
                                  );
                                  _audioManager.play();
                                },
                                child: const FaIcon(FontAwesomeIcons.play),
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 8,
                            right: 8,
                          ),
                          child: Divider(
                            height: 1,
                            thickness: 1,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
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
    ;
  }
}
