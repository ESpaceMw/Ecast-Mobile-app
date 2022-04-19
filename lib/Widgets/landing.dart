import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecast/Screens/view_chart.dart';
import 'package:ecast/Services/api.dart';
import 'package:ecast/Services/repos/repo.dart';
import 'package:ecast/Utils/constants.dart';
import 'package:ecast/Utils/logic.dart';
import 'package:ecast/Widgets/components/arts.dart';
import 'package:ecast/Widgets/components/business.dart';
import 'package:ecast/Widgets/components/education.dart';
import 'package:ecast/Widgets/components/top_tab_options.dart';
import 'package:ecast/cubit/charts_cubit.dart';
import 'package:ecast/cubit/podcasts_cubit.dart';
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
  int _currentBuilds = 0;
  @override
  void initState() {
    super.initState();
    // _getCharts();
  }

  @override
  Widget build(BuildContext context) {
    Repository repository = Repository(networkService: NetworkService());
    BlocProvider.of<ChartsCubit>(context).charts();
    DateTime now = DateTime.now();
    var timenow = int.parse(DateFormat('kk').format(now));
    String message = timeChecker(timenow);
    return ListView(
      // controller: _scrollController,
      // shrinkWrap: true,
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
                      .map((item) => GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) =>
                                      ViewChart(chartDetails: item)));
                            },
                            child: Container(
                              margin: const EdgeInsets.all(5.0),
                              child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5.0)),
                                  child: Stack(
                                    children: <Widget>[
                                      Image.network(
                                        item['header_image'],
                                        fit: BoxFit.cover,
                                        width:
                                            MediaQuery.of(context).size.width *
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
                                                Color.fromARGB(200, 0, 0, 0)
                                              ],
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                            ),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 20.0),
                                          child: Text(
                                            item['name'],
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'OpenSans'),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ))
                      .toList();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.14,
                        ),
                        child: CarouselSlider(
                          options: CarouselOptions(
                            autoPlay: false,
                            aspectRatio: 2.0,
                            enlargeCenterPage: true,
                          ),
                          items: imageSliders,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text("Recommended Podcasts", style: textStyle),
                      )
                    ],
                  );
                } else if (state is NetError) {
                  return Text("Hello");
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
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ],
    );
  }
}
