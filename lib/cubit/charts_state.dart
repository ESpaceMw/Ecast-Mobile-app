part of 'charts_cubit.dart';

@immutable
abstract class ChartsState {}

class ChartsInitial extends ChartsState {}

class ChartsLoading extends ChartsState {}

class ChartsLoaded extends ChartsState {
  final List<Charts> charts;

  ChartsLoaded({required this.charts});
}

class NetError extends ChartsState {
  final String msg;

  NetError({required this.msg});
}
