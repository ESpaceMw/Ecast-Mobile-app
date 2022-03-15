part of 'podcasts_cubit.dart';

@immutable
abstract class PodcastsState {}

class PodCastsLoading extends PodcastsState {}

class PodcastsInitial extends PodcastsState {}

class PodcastsLoaded extends PodcastsState {
  final List<Channels> subs;

  PodcastsLoaded({required this.subs});
}
