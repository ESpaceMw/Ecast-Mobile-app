import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecast/Models/charts.dart';
import 'package:ecast/Utils/constants.dart';
import 'package:ecast/Utils/logic.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScrollController _scrollController = ScrollController();

  // List<Charts> ParseCharts(String res) {
  //   final parsed = convert.jsonDecode(res).cast<Map<String, dynamic>>();
  //   return parsed.map<Charts>((json) => Charts.fromJson(json)).toList();
  // }

  // Future<List<Charts>> _getCharts() async {
  //   var response = await http.get(
  //       Uri.parse("https://jsonplaceholder.typicode.com/photos/?_limit=10"));
  //   return ParseCharts(response.body);
  // }

  @override
  void initState() {
    super.initState();
    // _getCharts();
  }

  @override
  Widget build(BuildContext context) {
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
            // FutureBuilder<List<Charts>>(
            //   future: _getCharts(),
            //   builder: (context, snapshot) {
            //     switch (snapshot.connectionState) {
            //       case ConnectionState.none:
            //         return const Center(
            //           child: Text("Fetch somethin"),
            //         );
            //       case ConnectionState.active:
            //       case ConnectionState.waiting:
            //         return Container(
            //           height: MediaQuery.of(context).size.height * 0.8,
            //           child: const Center(
            //             child: CircularProgressIndicator(),
            //           ),
            //         );
            //       case ConnectionState.done:
            //         if (snapshot.hasError) {
            //           return const Center(
            //             child: Text("Ooops, something went wrong"),
            //           );
            //         } else {
            //           return SnapChartList(charts: snapshot.data!);
            //         }
            //     }
            //   },
            // )
          ],
        ),
      ],
    );
  }
}

class SnapChartList extends StatelessWidget {
  const SnapChartList({Key? key, required this.charts}) : super(key: key);

  final List<Charts> charts;
  // int _focusedIndex = 4;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, index) {
        return CachedNetworkImage(
          imageUrl: charts[index].thumbnail,
          placeholder: (context, url) => const CircularProgressIndicator(
            color: btnColor,
          ),
        );
      },
      itemCount: charts.length,
    );
  }

  void ItemFocus(int p1) {
    print("Focused");
  }
}
