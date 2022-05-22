import 'package:ecast/Screens/charts_screen.dart';
import 'package:ecast/Screens/forgotpassword.dart';
import 'package:ecast/Screens/home_screen.dart';
import 'package:ecast/Screens/notes.dart';
import 'package:ecast/Screens/podcasts_list.dart';
import 'package:ecast/Screens/sign_in_screen.dart';
import 'package:ecast/Screens/sign_up_screen.dart';
import 'package:ecast/Screens/splash_screen.dart';
import 'package:ecast/Screens/wrapper.dart';
import 'package:ecast/Services/api.dart';
import 'package:ecast/Services/repos/repo.dart';
import 'package:ecast/Utils/constants.dart';
import 'package:ecast/cubit/charts_cubit.dart';
import 'package:ecast/cubit/podcasts_cubit.dart';
import 'package:ecast/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  late Repository repository;

  AppRouter() {
    repository = Repository(
      networkService: NetworkService(),
    );
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case wrapper:
        return MaterialPageRoute(
          builder: (_) => const Wrapper(),
        );
      case signUp:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => UserCubit(repository: repository),
            child: const SignUp(),
          ),
        );
      case signIn:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => UserCubit(repository: repository),
            child: const SignIn(),
          ),
        );
      case home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case note:
        return MaterialPageRoute(
          builder: (_) => const Notes(),
        );
      case forgetPassword:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => UserCubit(repository: repository),
            child: const ForgotPassword(),
          ),
        );
      case charts:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ChartsCubit(repository: repository),
            child: const ChartsScreen(),
          ),
        );
      case podcats:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: PodcastsCubit(repository: repository),
            child: const Podcasts(),
          ),
        );
      default:
        return null;
    }
  }
}
