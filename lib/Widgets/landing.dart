import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecast/Models/charts.dart';
import 'package:ecast/Utils/constants.dart';
import 'package:ecast/Utils/logic.dart';
import 'package:ecast/cubit/charts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    // _getCharts();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ChartsCubit>(context).charts();
    DateTime now = DateTime.now();
    var timenow = int.parse(DateFormat('kk').format(now));
    String message = timeChecker(timenow);
    return ListView(
      controller: _scrollController,
      shrinkWrap: true,
      children: [
        Stack(
          children: [
            ShaderMask(
              shaderCallback: (rect) => const LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black87,
                  kBackgroundColor,
                ],
              ).createShader(rect),
              blendMode: BlendMode.darken,
              child: Container(
                height: MediaQuery.of(context).size.height,
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
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      top: 10,
                    ),
                    child: Text(
                      message,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 10,
                    ),
                    child: const Icon(
                      Icons.notification_important,
                      size: 30,
                    ),
                  )
                ],
              ),
            ),
            BlocConsumer<ChartsCubit, ChartsState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                if (state is ChartsLoaded) {
                  final List<Widget> imageSliders = state.charts
                      .map((item) => Container(
                            margin: const EdgeInsets.all(5.0),
                            child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(5.0)),
                                child: Stack(
                                  children: <Widget>[
                                    Image.network(
                                      item.thumbnail,
                                      fit: BoxFit.cover,
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
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
                                              Color.fromARGB(0, 0, 0, 0)
                                            ],
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 20.0),
                                        child: const Text(
                                          'Title',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ))
                      .toList();
                  return Container(
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.2,
                    ),
                    child: CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        aspectRatio: 2.0,
                        enlargeCenterPage: true,
                      ),
                      items: imageSliders,
                    ),
                  );
                } else {
                  return Container(
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.3,
                    ),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: btnColor,
                      ),
                    ),
                  );
                }
              },
            )
          ],
        ),
      ],
    );
  }
}
