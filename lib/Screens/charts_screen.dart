import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecast/Models/charts.dart';
import 'package:ecast/Screens/view_chart.dart';
import 'package:ecast/Utils/constants.dart';
import 'package:ecast/cubit/charts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChartsScreen extends StatefulWidget {
  const ChartsScreen({Key? key}) : super(key: key);

  @override
  _ChartsScreenState createState() => _ChartsScreenState();
}

class _ChartsScreenState extends State<ChartsScreen> {
  final ScrollController _scrollController = ScrollController();

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
                return GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 4.0,
                  ),
                  itemCount: state.charts.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ViewChart(
                              chartDetails: state.charts[index],
                            ),
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
                                child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: CachedNetworkImage(
                                  imageUrl: state.charts[index]['header_image'],
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(
                                    color: btnColor,
                                  ),
                                ),
                              ),
                            )),
                            const SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Text(
                                state.charts[index]['name'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  // fontSize: 16,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
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
