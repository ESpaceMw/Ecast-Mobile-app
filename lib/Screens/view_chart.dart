import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecast/Models/charts.dart';
import 'package:ecast/Utils/constants.dart';
import 'package:flutter/material.dart';

class ViewChart extends StatelessWidget {
  final Charts chartDetails;
  const ViewChart({Key? key, required this.chartDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_back,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CachedNetworkImage(
                  imageUrl: chartDetails.thumbnail,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(
                    color: btnColor,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                const Text('Title', style: textStyle),
                // TODO : add other details
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          )

          // TODO: implement listview for podcasts
        ],
      ),
    );
  }
}
