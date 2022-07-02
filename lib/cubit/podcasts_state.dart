part of 'podcasts_cubit.dart';

@immutable
abstract class PodcastsState {}

class PodCastsLoading extends PodcastsState {}

class PodcastsInitial extends PodcastsState {}

class PodcastsLoaded extends PodcastsState {
  final List subs;

  PodcastsLoaded({required this.subs});
}

class PodcastSubscripted extends PodcastsState {
  final String msg;
  PodcastSubscripted({required this.msg});
}

class SubProcess extends PodcastsState {}

class Pod extends PodcastsState {
  final List arts;

  Pod({required this.arts});
}

class PodcastsError extends PodcastsState {
  final String msg;

  PodcastsError({required this.msg});
}

class FetchedEpisodes extends PodcastsState {
  final List episodes;

  FetchedEpisodes({required this.episodes});
}

class FetchingEpisodes extends PodcastsState {}

class Unsubscribed extends PodcastsState {
  final String msg;

  Unsubscribed({required this.msg});
}

class PlaylistsFetched extends PodcastsState {
  final List playlists;
  PlaylistsFetched({required this.playlists});
}
