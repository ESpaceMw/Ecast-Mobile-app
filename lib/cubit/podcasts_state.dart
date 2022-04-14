part of 'podcasts_cubit.dart';

@immutable
abstract class PodcastsState {}

class PodCastsLoading extends PodcastsState {}

class PodcastsInitial extends PodcastsState {}

class PodcastsLoaded extends PodcastsState {
  final List<Channels> subs;

  PodcastsLoaded({required this.subs});
}

class Pod extends PodcastsState {
  final List arts;

  Pod({required this.arts});
}

class PodcastsError extends PodcastsState {
  final String msg;

  PodcastsError({required this.msg});
}
