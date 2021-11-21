import 'package:ecast/Utils/constants.dart';
import 'package:ecast/Utils/logic.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchQuery = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          margin: const EdgeInsets.only(left: 10, right: 10),
          decoration: const BoxDecoration(
            color: codeColor,
            borderRadius: BorderRadius.all(
              Radius.circular(
                10.8,
              ),
            ),
          ),
          child: TextFormField(
            controller: _searchQuery,
            decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.search_rounded,
              ),
              hintText: "Search",
              border: InputBorder.none,
            ),
            onFieldSubmitted: searchData,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Made for You",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
