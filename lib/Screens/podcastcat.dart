import 'package:ecast/cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PodcastCat extends StatelessWidget {
  final String category;
  const PodcastCat({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SearchCubit>(context).filterPodcasts(category);
    return Scaffold();
  }
}
