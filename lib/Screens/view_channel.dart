import 'package:flutter/material.dart';

class ViewChannel extends StatefulWidget {
  const ViewChannel({Key? key}) : super(key: key);

  @override
  _ViewChannelState createState() => _ViewChannelState();
}

class _ViewChannelState extends State<ViewChannel> {
  @override
  Widget build(BuildContext context) {
    Object? channel = ModalRoute.of(context)!.settings.arguments;
    print(channel);
    return Scaffold(
      body: Text('hello'),
    );
  }
}
