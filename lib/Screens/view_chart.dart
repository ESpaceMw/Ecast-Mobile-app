import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecast/Models/charts.dart';
import 'package:ecast/Screens/view_podcasts.dart';
import 'package:ecast/Utils/constants.dart';
import 'package:ecast/Widgets/components/popmenu.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ViewChart extends StatelessWidget {
  final dynamic chartDetails;
  const ViewChart({Key? key, required this.chartDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(chartDetails['podcasts']);
    return Scaffold(
      backgroundColor: Colors.black87,
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      width: MediaQuery.of(context).size.width * 0.5,
                      imageUrl: chartDetails['header_image'],
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(
                        color: btnColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Flexible(
                  child: Text(
                    chartDetails['name'],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: chartDetails['podcasts'].length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: recColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => ViewPodcast(
                                details: chartDetails['podcasts'][index],
                              ),
                            ),
                          );
                        },
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              width: MediaQuery.of(context).size.width * 0.12,
                              imageUrl: chartDetails['podcasts'][index]
                                  ['cover_art'],
                            ),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(chartDetails['podcasts'][index]['title'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                              Text(chartDetails['podcasts'][index]['author'],
                                  style: const TextStyle(fontSize: 12))
                            ],
                          ),
                          trailing: const Popmenu(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
