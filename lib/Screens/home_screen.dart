import 'package:cached_network_image/cached_network_image.dart';
import 'package:coolicons/coolicons.dart';
import 'package:ecast/Screens/player/music_player.dart';
import 'package:ecast/Screens/screen_options.dart';
import 'package:ecast/Utils/audioinstance.dart';
import 'package:ecast/Utils/constants.dart';
import 'package:ecast/Widgets/bottom_nav_options.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:marquee/marquee.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final AudioManager _audioManager;

  @override
  void initState() {
    super.initState();
    _audioManager = AudioManager();
  }

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabBodies[_selectedIndex],
      bottomNavigationBar: Container(
        height: playing ? 120 : 65,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // ignore: avoid_unnecessary_containers
            playing
                ? GestureDetector(
                    onTap: () {
                      pushNewScreen(context, screen: const MusicPlayer());
                    },
                    // ignore: avoid_unnecessary_containers
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ValueListenableBuilder<ButtonState>(
                            valueListenable: _audioManager.btnNotifier,
                            builder: (_, value, __) {
                              switch (value) {
                                case ButtonState.loading:
                                  return Container(
                                    margin: const EdgeInsets.all(8.0),
                                    width: 32.0,
                                    height: 32.0,
                                    child: const CircularProgressIndicator(),
                                  );
                                case ButtonState.paused:
                                  return IconButton(
                                      iconSize: 24.0,
                                      onPressed: () {
                                        _audioManager.play();
                                      },
                                      icon: const FaIcon(
                                        FontAwesomeIcons.play,
                                      ));

                                case ButtonState.playing:
                                  return IconButton(
                                    iconSize: 24.0,
                                    onPressed: () {
                                      _audioManager.pause();
                                    },
                                    icon: const FaIcon(
                                      FontAwesomeIcons.pause,
                                    ),
                                  );
                              }
                            },
                          ),
                          ValueListenableBuilder(
                              valueListenable: _audioManager.artWork,
                              builder: (_, artwork, __) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Material(
                                    elevation: 10.0,
                                    child: CachedNetworkImage(
                                      width: MediaQuery.of(context).size.width *
                                          0.1,
                                      imageUrl: artwork.toString(),
                                      placeholder: (context, url) =>
                                          const Center(
                                        child: CircularProgressIndicator(
                                          color: btnColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                          const SizedBox(
                            width: 14,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                height: 20,
                                child: ValueListenableBuilder<String>(
                                    valueListenable:
                                        _audioManager.CurrentSongTitle,
                                    builder: (_, title, __) {
                                      return Marquee(
                                        text: title,
                                        scrollAxis: Axis.horizontal,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        numberOfRounds: 3,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                        velocity: 50.0,
                                        pauseAfterRound:
                                            const Duration(seconds: 1),
                                      );
                                    }),
                              ),
                              ValueListenableBuilder(
                                  valueListenable: _audioManager.CurrentArtist,
                                  builder: (_, artist, __) {
                                    return Text(
                                      artist.toString(),
                                      style: const TextStyle(
                                        fontSize: 13,
                                      ),
                                      textAlign: TextAlign.center,
                                    );
                                  })
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          ValueListenableBuilder<bool>(
                              valueListenable:
                                  _audioManager.isFirstSongNotifier,
                              builder: (_, isfirst, __) {
                                return IconButton(
                                  onPressed: (isfirst)
                                      ? null
                                      : _audioManager.onPreviousBtn,
                                  iconSize: 22,
                                  icon: const FaIcon(
                                    FontAwesomeIcons.backwardStep,
                                  ),
                                );
                              }),
                          ValueListenableBuilder<bool>(
                              valueListenable: _audioManager.isLastSongNotifier,
                              builder: (_, isLast, __) {
                                return IconButton(
                                  onPressed:
                                      (isLast) ? null : _audioManager.onNextBtn,
                                  iconSize: 22,
                                  icon: const FaIcon(
                                    FontAwesomeIcons.forwardStep,
                                  ),
                                );
                              })
                        ],
                      ),
                    ),
                  )
                : Container(
                    height: 0,
                    color: kBackgroundColor,
                  ),
            const SizedBox(
              height: 8,
            ),
            BottomNavigationBar(
              type: BottomNavigationBarType.shifting,
              items: bottomTabs,
              onTap: _changeIndex,
              showUnselectedLabels: false,
              selectedItemColor: btnColor,
              unselectedItemColor: whiteColor,
              currentIndex: _selectedIndex,
              backgroundColor: kBackgroundColor,
            ),
          ],
        ),
      ),
    );
  }

  void _changeIndex(index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

// PersistentTabView(
//         context,
//         controller: _controller,
//         navBarStyle: NavBarStyle.style10,
//         navBarHeight: 60,
//         items: [
//           PersistentBottomNavBarItem(
//             icon: const Icon(Coolicons.home_alt_fill),
//             title: "Home",
//             activeColorPrimary: btnColor,
//             activeColorSecondary: whiteColor,
//             inactiveColorPrimary: Colors.white,
//             textStyle: const TextStyle(
//               fontSize: 15,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           PersistentBottomNavBarItem(
//             icon: const FaIcon(FontAwesomeIcons.searchengin),
//             title: "Search",
//             activeColorPrimary: btnColor,
//             activeColorSecondary: whiteColor,
//             inactiveColorPrimary: Colors.white,
//             textStyle: const TextStyle(
//               fontSize: 15,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           PersistentBottomNavBarItem(
//             icon: const Icon(
//               Icons.video_library_outlined,
//             ),
//             title: "library",
//             activeColorPrimary: btnColor,
//             activeColorSecondary: whiteColor,
//             inactiveColorPrimary: Colors.white,
//             textStyle: const TextStyle(
//               fontSize: 15,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           PersistentBottomNavBarItem(
//             icon: const FaIcon(FontAwesomeIcons.bars),
//             title: "Menu",
//             activeColorPrimary: btnColor,
//             activeColorSecondary: whiteColor,
//             inactiveColorPrimary: Colors.white,
//             textStyle: const TextStyle(
//               fontSize: 15,
//               fontWeight: FontWeight.bold,
//             ),
//           )
//         ],
//         screens: tabBodies,
//         stateManagement: true,
//         backgroundColor: kBackgroundColor,
//       ),
