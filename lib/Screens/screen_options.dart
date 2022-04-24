import 'package:ecast/Services/api.dart';
import 'package:ecast/Services/repos/repo.dart';
import 'package:ecast/Widgets/landing.dart';
import 'package:ecast/Widgets/menu.dart';
import 'package:ecast/Widgets/library.dart';
import 'package:ecast/Widgets/search.dart';
import 'package:ecast/cubit/charts_cubit.dart';
import 'package:ecast/cubit/user_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Repository repository = Repository(networkService: NetworkService());

List<Widget> tabBodies = [
  BlocProvider(
    create: (context) => ChartsCubit(repository: repository),
    child: const Home(),
  ),
  const Search(),
  const Library(),
  BlocProvider(
    create: (context) => UserCubit(repository: repository),
    child: const Menu(),
  ),
];
