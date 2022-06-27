import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecast/Utils/Notifiers/progressNotifier.dart';
import 'package:ecast/Utils/Notifiers/repeat_Btn_Notifier.dart';
import 'package:ecast/Utils/audioinstance.dart';
import 'package:ecast/Utils/constants.dart';
import 'package:ecast/Widgets/Errors/httpex.dart';
import 'package:ecast/Widgets/Errors/socketerr.dart';
import 'package:ecast/Widgets/components/popmenu.dart';
import 'package:ecast/cubit/charts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MusicPlayer extends StatefulWidget {
  final String img;
  const MusicPlayer({
    Key? key,
    required this.img,
  }) : super(key: key);

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  late final AudioManager _audioManager;
  Color bg = const Color(0xFF101010);
  String dropDownvalue = "1x";

  _getColor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (widget.img == '') {
      final bgColor = prefs.getInt("color");
      Color newBgColor = Color(bgColor!);
      setState(() {
        bg = newBgColor;
      });
    } else {
      var cc =
          await PaletteGenerator.fromImageProvider(NetworkImage(widget.img));
      setState(() {
        bg = cc.dominantColor!.color;
      });
      prefs.setInt("color", cc.dominantColor!.color.value);
    }
  }

  @override
  void initState() {
    super.initState();
    _audioManager = AudioManager();
    _getColor();
  }

  @override
  Widget build(BuildContext context) {
    // _audioManager.play();
    BlocProvider.of<ChartsCubit>(context).charts();
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            scaffoldColor,
            scaffoldColor,
            bg,
          ],
          tileMode: TileMode.repeated,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          left: 10,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const FaIcon(FontAwesomeIcons.angleDown),
                        ),
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
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Card(
                          elevation: 80.0,
                          shadowColor: Colors.black87,
                          child: CachedNetworkImage(
                            width: MediaQuery.of(context).size.width * 0.8,
                            imageUrl: artwork.toString(),
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
                          thumbCanPaintOutsideBar: false,
                          baseBarColor: Colors.grey[600],
                          thumbColor: whiteColor,
                          progressBarColor: whiteColor,
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
                    DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: dropDownvalue,
                        // dropdownColor: whiteColor,
                        onChanged: (String? value) {
                          setState(() {
                            dropDownvalue = value!;
                          });
                        },
                        items: <String>['1x', '2x', '3x']
                            .map<DropdownMenuItem<String>>((String speed) {
                          return DropdownMenuItem<String>(
                            value: speed,
                            child: Text(speed),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
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
                            onPressed:
                                (isLast) ? null : _audioManager.onNextBtn,
                            iconSize: 42,
                            icon: const FaIcon(
                              FontAwesomeIcons.angleRight,
                            ),
                          );
                        }),
                    const SizedBox(
                      width: 10,
                    ),
                    ValueListenableBuilder<RepeatState>(
                      valueListenable: _audioManager.repeatNotifier,
                      builder: (context, value, child) {
                        Icon icon;
                        switch (value) {
                          case RepeatState.off:
                            icon = const Icon(Icons.repeat, color: Colors.grey);
                            break;
                          case RepeatState.repeatSong:
                            icon = const Icon(Icons.repeat_one);
                            break;
                          case RepeatState.repeatPlaylist:
                            icon = const Icon(Icons.repeat);
                            break;
                        }
                        return IconButton(
                          icon: icon,
                          onPressed: _audioManager.repeat,
                        );
                      },
                    ),
                  ],
                ),
                Container(
                  height: 600,
                  // decoration: BoxDecoration(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: DraggableScrollableSheet(
                      initialChildSize: 0.9,
                      builder: (BuildContext context,
                          ScrollController scrollcontroller) {
                        return Container(
                          decoration: BoxDecoration(
                              color: kBackgroundColor,
                              borderRadius: const BorderRadius.horizontal(
                                left: Radius.circular(10.0),
                                right: Radius.circular(10.0),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(
                                    0.4,
                                  ),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 2),
                                ),
                              ]),
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomScrollView(
                                slivers: [
                                  SliverFixedExtentList(
                                      delegate: SliverChildListDelegate([
                                        const Text(
                                          'Top Charts',
                                          style: podstyles,
                                        ),
                                      ]),
                                      itemExtent: 50),
                                  BlocBuilder<ChartsCubit, ChartsState>(
                                    builder: (context, state) {
                                      if (state is Charts) {
                                        return SliverList(
                                          delegate: SliverChildBuilderDelegate(
                                            (context, index) {
                                              return ListTile(
                                                  trailing: ClipRRect(
                                                      child: CachedNetworkImage(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.5,
                                                imageUrl: state.charts[index]
                                                    ['header_image'],
                                                placeholder: (context, url) =>
                                                    const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: btnColor,
                                                  ),
                                                ),
                                              )));
                                            },
                                            childCount: state.charts.length,
                                          ),
                                        );
                                      } else {
                                        if (state is ChartsLoading) {
                                          return SliverFixedExtentList(
                                            delegate: SliverChildListDelegate([
                                              const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        color: btnColor),
                                              ),
                                            ]),
                                            itemExtent: 100,
                                          );
                                        } else if (state is NetError) {
                                          return SliverFixedExtentList(
                                            delegate: SliverChildListDelegate([
                                              SocketErr(
                                                msg: state.msg,
                                              )
                                            ]),
                                            itemExtent: 100,
                                          );
                                        } else {
                                          return SliverFixedExtentList(
                                              delegate:
                                                  SliverChildListDelegate([
                                                const HttpExc(
                                                    msg:
                                                        "Server Error! Contact System Admin"),
                                              ]),
                                              itemExtent: 100);
                                        }
                                      }
                                    },
                                  )
                                ],
                              )),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
