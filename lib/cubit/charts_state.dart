part of 'charts_cubit.dart';

@immutable
abstract class ChartsState {}

class ChartsInitial extends ChartsState {}

class ChartsLoading extends ChartsState {}

class ChartsLoaded extends ChartsState {
  final List charts;
  final List podcasts;
  final List playlists;
  final List data;

  ChartsLoaded({
    required this.charts,
    required this.data,
    required this.podcasts,
    required this.playlists,
  });
}

class Charts extends ChartsState {
  final List charts;

  Charts({
    required this.charts,
  });
}

class NetError extends ChartsState {
  final String msg;

  NetError({required this.msg});
}

class HttpError extends ChartsState {
  final String msg;

  HttpError({required this.msg});
}

class Exception extends ChartsState {
  final String msg;

  Exception({required this.msg});
}
