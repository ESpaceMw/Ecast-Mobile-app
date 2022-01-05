import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecast/Models/charts.dart';
import 'package:ecast/Screens/view_chart.dart';
import 'package:ecast/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ChartsScreen extends StatefulWidget {
  const ChartsScreen({Key? key}) : super(key: key);

  @override
  _ChartsScreenState createState() => _ChartsScreenState();
}

class _ChartsScreenState extends State<ChartsScreen> {
  final ScrollController _scrollController = ScrollController();

  List<Charts> parsePhotos(String responseBody) {
    final parsed =
        convert.jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Charts>((json) => Charts.fromJson(json)).toList();
  }

  Future<List<Charts>> _getChannels() async {
    var url = 'https://jsonplaceholder.typicode.com/photos/?_limit=16';
    var response = await http.get(Uri.parse(url));
    var jsonData = convert.jsonDecode(response.body);
    return parsePhotos(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        controller: _scrollController,
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back_ios),
                ),
                const SizedBox(
                  width: 7,
                ),
                const Text(
                  'Charts',
                  style: textStyle,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          FutureBuilder<List<Charts>>(
            future: _getChannels(),
            builder: (context, snapshot) {
              // ignore: unused_local_variable
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return const Center(
                    child: Text("Fetch somethin"),
                  );

                case ConnectionState.active:
                case ConnectionState.waiting:
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );

                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text("Ooops, something went wrong"),
                    );
                  } else {
                    if (snapshot.data != []) {
                      return ChartsList(photos: snapshot.data!);
                    } else {
                      return const Center(
                        child: Text("No subscriptions"),
                      );
                    }
                  }
              }
            },
          ),
        ],
      ),
    );
  }
}

class ChartsList extends StatelessWidget {
  const ChartsList({Key? key, required this.photos}) : super(key: key);
  final List<Charts> photos;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 4.0,
      ),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ViewChart(chartDetails: photos[index]),
              ),
            );
          },
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            color: Colors.blueGrey[900],
            child: Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Flexible(
                      child: Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 9),
                    child: CachedNetworkImage(
                      imageUrl: photos[index].thumbnail,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(
                        color: btnColor,
                      ),
                    ),
                  )),
                  const Text('Title')
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
