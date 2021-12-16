import 'package:ecast/Models/channels.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Subscriptions extends StatefulWidget {
  const Subscriptions({Key? key}) : super(key: key);

  @override
  _SubscriptionsState createState() => _SubscriptionsState();
}

class _SubscriptionsState extends State<Subscriptions> {
  Future _getChannels() async {
    var url = 'https://jsonplaceholder.typicode.com/photos/?_limit=16';
    var response = await http.get(Uri.parse(url));
    var jsonData = convert.jsonDecode(response.body);
    return jsonData.map((data) => Channels.fromJson(data)).toList();
  }

  @override
  void initState() {
    _getChannels();
    super.initState();
  }

  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getChannels(),
      builder: (context, snapshot) {
        // ignore: unused_local_variable
        var inf = snapshot.data;
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
                return GridView.builder(
                  controller: _scrollController,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return Container(
                      alignment: Alignment.center,
                      color: Colors.red,
                      child: Text("Heeee"),
                    );
                  },
                  itemCount: 16,
                );
              } else {
                return const Center(
                  child: Text("No subscriptions"),
                );
              }
            }
        }
      },
    );
  }
}
