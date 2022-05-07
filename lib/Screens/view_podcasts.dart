import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecast/Screens/player/music_player.dart';
import 'package:ecast/Screens/view_ep.dart';
import 'package:ecast/Services/api.dart';
import 'package:ecast/Services/repos/repo.dart';
import 'package:ecast/Utils/constants.dart';
import 'package:ecast/cubit/podcasts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

final Repository repository = Repository(networkService: NetworkService());

class ViewPodcast extends StatelessWidget {
  final dynamic details;
  const ViewPodcast({Key? key, required this.details}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PodcastsCubit>(context).fetchEpisodes(details['id']);
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
                    imageUrl: details['cover_art'],
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
            details['title'],
            style: titleStyles,
            textAlign: TextAlign.center,
          ),
          Text(
            details['author'],
            style: const TextStyle(
              color: Colors.blue,
            ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              details['description'],
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
              GestureDetector(
                onTap: () {},
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
                    "Subscribe",
                    style: TextStyle(
                      color: whiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
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
                                  cover: details['cover_art'],
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
                                imageUrl: details['cover_art'],
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
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Text(
                                        state.episodes[index]['name'],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
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
                                  width: 30,
                                ),
                                const FaIcon(FontAwesomeIcons.download),
                                const SizedBox(
                                  width: 15,
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(
                                    state.episodes[index]['runtime'],
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            trailing: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  pushNewScreen(
                                    context,
                                    screen: MusicPlayer(
                                        episode: index,
                                        img: details['cover_art'],
                                        pd: state.episodes,
                                        author: details['author']),
                                    withNavBar: false,
                                  );
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
  }
}
