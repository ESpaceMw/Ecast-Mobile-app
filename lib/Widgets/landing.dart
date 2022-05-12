import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecast/Screens/view_chart.dart';
import 'package:ecast/Screens/view_podcasts.dart';
import 'package:ecast/Screens/wrapper.dart';
import 'package:ecast/Services/api.dart';
import 'package:ecast/Services/repos/repo.dart';
import 'package:ecast/Utils/constants.dart';
import 'package:ecast/Utils/logic.dart';
import 'package:ecast/Widgets/Errors/socketerr.dart';
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

Repository repos = Repository(networkService: NetworkService());

class _HomeState extends State<Home> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    Repository repository = Repository(networkService: NetworkService());
    BlocProvider.of<ChartsCubit>(context).charts();
    DateTime now = DateTime.now();
    var timenow = int.parse(DateFormat('kk').format(now));
    String message = timeChecker(timenow);
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      color: Colors.black87,
      child: ListView(
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
                      image: AssetImage('assets/images/ob.jpg'),
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
                  if (state is Exception) {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const Wrapper()),
                        (route) => false);
                  }
                },
                builder: (context, state) {
                  if (state is ChartsLoaded) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 300.0,
                          margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.13,
                          ),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.charts.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, index) {
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
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 30, right: 20),
                                    child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10.0)),
                                        child: Stack(
                                          children: <Widget>[
                                            Image.network(
                                              state.charts[index]
                                                  ['header_image'],
                                              fit: BoxFit.cover,
                                              width: size.width * 0.7,
                                              height: size.height * 0.9,
                                            ),
                                            Positioned(
                                              bottom: 0.0,
                                              left: 0.0,
                                              right: 0.0,
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Color.fromARGB(
                                                          200, 0, 0, 0),
                                                      Color.fromARGB(
                                                          200, 0, 0, 0)
                                                    ],
                                                    begin:
                                                        Alignment.bottomCenter,
                                                    end: Alignment.topCenter,
                                                  ),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10.0,
                                                        horizontal: 20.0),
                                                child: Text(
                                                  state.charts[index]['name'],
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'OpenSans'),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
                                );
                              }),
                        ),
                      ],
                    );
                  } else if (state is NetError) {
                    return SocketErr(msg: state.msg);
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
      ),
    );
  }
}
