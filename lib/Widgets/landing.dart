import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecast/Screens/playlists_details.dart';
import 'package:ecast/Screens/view_chart.dart';
import 'package:ecast/Screens/view_podcasts.dart';
import 'package:ecast/Screens/wrapper.dart';
import 'package:ecast/Services/api.dart';
import 'package:ecast/Services/repos/repo.dart';
import 'package:ecast/Utils/constants.dart';
import 'package:ecast/Utils/logic.dart';
import 'package:ecast/Widgets/Errors/socketerr.dart';
import 'package:ecast/Widgets/components/indicator.dart';
import 'package:ecast/Widgets/landingPageWidgets/ecast_playlists.dart';
import 'package:ecast/Widgets/landingPageWidgets/radio_button.dart';
import 'package:ecast/Widgets/landingPageWidgets/recently_played.dart';
import 'package:ecast/cubit/charts_cubit.dart';
import 'package:ecast/cubit/podcasts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

Repository repos = Repository(networkService: NetworkService());

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ChartsCubit>(context).charts();
    DateTime now = DateTime.now();
    var timenow = int.parse(DateFormat('kk').format(now));
    String message = timeChecker(timenow);
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              Stack(
                children: [
                  ShaderMask(
                    shaderCallback: (rect) => LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.center,
                      colors: [
                        Colors.transparent,
                        Colors.black,
                        Colors.black.withOpacity(0.7),
                      ],
                    ).createShader(rect),
                    blendMode: BlendMode.darken,
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/ob.jpg'),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              Colors.black45, BlendMode.dstATop),
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
                            left: 12,
                          ),
                          child: Text(
                            message,
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // showModalBottomSheet(
                            //     context: context,
                            //     builder: (BuildContext context) {
                            //       return Container(
                            //         decoration: BoxDecoration(
                            //             borderRadius:
                            //                 BorderRadius.circular(10.0)),
                            //         height: MediaQuery.of(context).size.height *
                            //             0.5,
                            //       );
                            //     });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                              top: 10,
                            ),
                            child: const FaIcon(
                              FontAwesomeIcons.bell,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  BlocConsumer<ChartsCubit, ChartsState>(
                    listener: (context, state) {
                      if (state is Exception) {
                        pushNewScreen(
                          context,
                          screen: const Wrapper(),
                          withNavBar: false,
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is ChartsLoaded) {
                        return data(size: size, state: state);
                      } else if (state is NetError) {
                        return SocketError(
                          state: state,
                        );
                      } else if (state is HttpError) {
                        return HttpError(state: state);
                      } else {
                        return const CirculaIndicator();
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HttpError extends StatelessWidget {
  final state;
  const HttpError({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            Text(
              state.msg,
              style: textStyle,
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () => BlocProvider.of<ChartsCubit>(context).charts(),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: const BoxDecoration(
                  color: btnColor,
                ),
                child: const Text(
                  "Retry",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SocketError extends StatelessWidget {
  final state;
  const SocketError({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            Text(
              state.msg,
              style: textStyle,
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () => BlocProvider.of<ChartsCubit>(context).charts(),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: const BoxDecoration(
                  color: btnColor,
                ),
                child: const Text(
                  "Retry",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class data extends StatelessWidget {
  final state;
  const data({
    Key? key,
    required this.size,
    required this.state,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            height: 320.0,
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.11,
            ),
            child: CarouselSlider.builder(
              itemCount: state.charts.length,
              options: CarouselOptions(
                height: 320,
                // enableInfiniteScroll: false,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
              ),
              itemBuilder: (context, index, realIdx) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ViewChart(
                          chartDetails: state.charts[index],
                        ),
                      ),
                    );
                  },
                  child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      child: Stack(
                        children: <Widget>[
                          Image.network(
                            state.charts[index]['header_image'],
                            fit: BoxFit.cover,
                            width: size.width * 0.7,
                            height: size.height,
                          ),
                          Positioned(
                            bottom: 0.0,
                            left: 0.0,
                            right: 0.0,
                            child: Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromARGB(200, 0, 0, 0),
                                    Color.fromARGB(200, 0, 0, 0)
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.center,
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 10.0,
                                horizontal: 20.0,
                              ),
                              child: Text(
                                state.charts[index]['name'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'OpenSans',
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                );
              },
            )),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.02,
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: btnColor,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Wrap(
              // direction: Axis.vertical,
              children: [
                Row(children: [
                  const SizedBox(
                    width: 8,
                  ),
                  Image.asset(
                    'assets/logos/live.png',
                    width: 50,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const RadioOption()
                ])
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Text('Jump Back In', style: textStyle),
        ),
        const SizedBox(
          height: 12,
        ),
        RecentlyPlayed(state: state),
        const SizedBox(
          height: 20,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Text(
            "Ecast Playlists",
            style: textStyle,
          ),
        ),
        EcastPlaylist(state: state, size: size)
      ],
    );
  }
}
