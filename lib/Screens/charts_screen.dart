import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecast/Models/charts.dart';
import 'package:ecast/Screens/view_chart.dart';
import 'package:ecast/Utils/constants.dart';
import 'package:ecast/cubit/charts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ChartsScreen extends StatefulWidget {
  const ChartsScreen({Key? key}) : super(key: key);

  @override
  _ChartsScreenState createState() => _ChartsScreenState();
}

class _ChartsScreenState extends State<ChartsScreen> {
  final ScrollController _scrollController = ScrollController();

  // List<Charts> parsePhotos(String responseBody) {
  //   final parsed =
  //       convert.jsonDecode(responseBody).cast<Map<String, dynamic>>();
  //   return parsed.map<Charts>((json) => Charts.fromJson(json)).toList();
  // }

  // Future<List<Charts>> _getChannels() async {
  //   var url = 'https://jsonplaceholder.typicode.com/photos/?_limit=16';
  //   var response = await http.get(Uri.parse(url));
  //   var jsonData = convert.jsonDecode(response.body);
  //   return parsePhotos(response.body);
  // }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ChartsCubit>(context).charts();
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
          BlocConsumer<ChartsCubit, ChartsState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              if (state is ChartsLoaded) {
                return ChartsList(photos: state.charts);
              } else {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.76,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: btnColor,
                    ),
                  ),
                );
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
          child: Container(
            width: 16,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: recColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: [
                Flexible(
                    child: CachedNetworkImage(
                  imageUrl: photos[index].thumbnail,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(
                    color: btnColor,
                  ),
                )),
                const Text('Title')
              ],
            ),
          ),
        );
      },
    );
  }
}
