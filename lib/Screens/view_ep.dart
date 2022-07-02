import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecast/Screens/player/music_player.dart';
import 'package:ecast/Screens/view_podcasts.dart';
import 'package:ecast/Services/api.dart';
import 'package:ecast/Services/repos/repo.dart';
import 'package:ecast/Utils/audioinstance.dart';
import 'package:ecast/Utils/constants.dart';
import 'package:ecast/cubit/podcasts_cubit.dart';
import 'package:ecast/cubit/search_cubit.dart';
import 'package:ecast/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:share_plus/share_plus.dart';

Repository repo = Repository(networkService: NetworkService());

class ViewEp extends StatefulWidget {
  final dynamic ep;
  final String cover;
  final String author;
  final String title;
  final String category;
  final dynamic id;
  final String coverArt;
  const ViewEp({
    Key? key,
    required this.ep,
    required this.cover,
    required this.author,
    required this.title,
    required this.category,
    required this.id,
    required this.coverArt,
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
    data.clear();
    data.add(widget.ep);
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SearchCubit>(context).filterPodcasts(widget.category);
    return Scaffold(
      body: SafeArea(
        child: ListView(
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
                    shaderCallback: (rect) => LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        kBackgroundColor,
                        kBackgroundColor,
                        Colors.black.withOpacity(0.7),
                      ],
                    ).createShader(rect),
                    blendMode: BlendMode.darken,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            widget.coverArt,
                          ),
                          fit: BoxFit.cover,
                          colorFilter: const ColorFilter.mode(
                              Colors.black54, BlendMode.dstIn),
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
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: CachedNetworkImage(
                              width: MediaQuery.of(context).size.width * 0.4,
                              imageUrl: widget.cover,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(
                                color: btnColor,
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
                    children: [
                      const Icon(
                        Icons.playlist_add,
                        size: 30,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const FaIcon(
                        FontAwesomeIcons.circleArrowDown,
                        // size: 20,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Share.share(
                            "ecast.espacemw.com/${widget.title}",
                            subject: "My Podcast",
                          );
                        },
                        child: const Icon(
                          Icons.share,
                          size: 26,
                        ),
                      ),
                      const SizedBox(
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
            ),
            const SizedBox(
              height: 10,
            ),
            BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                if (state is FetchedCat) {
                  return GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 2.0,
                        crossAxisSpacing: 0,
                      ),
                      itemCount: state.categories.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MultiBlocProvider(
                                providers: [
                                  BlocProvider.value(
                                      value: PodcastsCubit(repository: repo)),
                                  BlocProvider.value(
                                    value: UserCubit(repository: repo),
                                  )
                                ],
                                child: ViewPodcast(
                                    details: state.categories[index]),
                              ),
                            ));
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                              left: 15,
                            ),
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 13),
                                  child: CachedNetworkImage(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    imageUrl: state.categories[index]
                                        ['cover_art'],
                                    placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(
                                        color: btnColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                } else {
                  return const Center(
                    child: CircularProgressIndicator(color: btnColor),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
