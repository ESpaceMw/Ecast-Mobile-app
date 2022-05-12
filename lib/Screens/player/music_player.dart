import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecast/Utils/Notifiers/progressNotifier.dart';
import 'package:ecast/Utils/Notifiers/repeat_Btn_Notifier.dart';
import 'package:ecast/Utils/audioinstance.dart';
import 'package:ecast/Utils/constants.dart';
import 'package:ecast/Widgets/components/popmenu.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:drop_shadow_image/drop_shadow_image.dart';

class MusicPlayer extends StatefulWidget {
  final dynamic episode;
  final String img;
  final List pd;
  final String author;
  const MusicPlayer({
    Key? key,
    required this.episode,
    required this.img,
    required this.pd,
    required this.author,
  }) : super(key: key);

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  late final AudioManager _audioManager;
  Color bg = Colors.black87;

  _getColor() async {
    var cc = await PaletteGenerator.fromImageProvider(NetworkImage(widget.img));
    setState(() {
      bg = cc.dominantColor!.color;
    });
  }

  @override
  void initState() {
    super.initState();
    _getColor();
    _audioManager =
        AudioManager(widget.pd, widget.episode, widget.img, widget.author);
  }

  @override
  Widget build(BuildContext context) {
    _audioManager.play();
    return Scaffold(
      backgroundColor: bg,
      body: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back),
                    ),
                    const Popmenu(),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ValueListenableBuilder(
                  valueListenable: _audioManager.artWork,
                  builder: (_, artwork, __) {
                    // print(artwork);
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Material(
                        elevation: 10.0,
                        child: CachedNetworkImage(
                          width: MediaQuery.of(context).size.width * 0.8,
                          imageUrl: widget.img,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(
                              color: btnColor,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  ValueListenableBuilder<String>(
                      valueListenable: _audioManager.CurrentSongTitle,
                      builder: (_, title, __) {
                        return Text(
                          title,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        );
                      }),
                  const SizedBox(
                    height: 5,
                  ),
                  ValueListenableBuilder(
                      valueListenable: _audioManager.CurrentArtist,
                      builder: (_, artist, __) {
                        return Text(
                          artist.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        );
                      })
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.1,
                  right: MediaQuery.of(context).size.width * 0.1,
                ),
                child: ValueListenableBuilder<ProgressBarState>(
                    valueListenable: _audioManager.progressNotifier,
                    builder: (_, value, __) {
                      return ProgressBar(
                        baseBarColor: Colors.grey,
                        progressBarColor: btnColor,
                        progress: value.current,
                        buffered: value.buffered,
                        total: value.total,
                        onSeek: _audioManager.seek,
                      );
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ValueListenableBuilder(
                  //     valueListenable: _audioManager.repeatNotifier,
                  //     builder: (context, state, child) {
                  //       Icon icon =
                  //           const Icon(Icons.repeat, color: Colors.grey);
                  //       switch (state) {
                  //         case RepeatState.off:
                  //           icon = const Icon(Icons.repeat, color: Colors.grey);
                  //           break;
                  //         case RepeatState.repeatSong:
                  //           icon = const Icon(Icons.repeat_one);
                  //           break;
                  //         case RepeatState.repeatPlaylist:
                  //           icon = const Icon(Icons.repeat);
                  //           break;
                  //       }
                  //       return IconButton(
                  //         icon: icon,
                  //         onPressed: _audioManager.repeat,
                  //       );
                  //     }),
                  ValueListenableBuilder<bool>(
                      valueListenable: _audioManager.isFirstSongNotifier,
                      builder: (_, isfirst, __) {
                        return IconButton(
                          onPressed:
                              (isfirst) ? null : _audioManager.onPreviousBtn,
                          iconSize: 42,
                          icon: const FaIcon(
                            FontAwesomeIcons.angleLeft,
                          ),
                        );
                      }),
                  const SizedBox(
                    width: 10,
                  ),
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
                              iconSize: 42.0,
                              onPressed: () {
                                _audioManager.play();
                              },
                              icon: const FaIcon(
                                FontAwesomeIcons.play,
                              ));

                        case ButtonState.playing:
                          return IconButton(
                            iconSize: 42.0,
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
                  const SizedBox(
                    width: 10,
                  ),
                  ValueListenableBuilder<bool>(
                      valueListenable: _audioManager.isLastSongNotifier,
                      builder: (_, isLast, __) {
                        return IconButton(
                          onPressed: (isLast) ? null : _audioManager.onNextBtn,
                          iconSize: 42,
                          icon: const FaIcon(
                            FontAwesomeIcons.angleRight,
                          ),
                        );
                      })
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
