import 'package:bloc/bloc.dart';
import 'package:ecast/Models/channels.dart';
import 'package:ecast/Services/repos/repo.dart';
import 'package:meta/meta.dart';

part 'podcasts_state.dart';

class PodcastsCubit extends Cubit<PodcastsState> {
  final Repository repository;

  PodcastsCubit({required this.repository}) : super(PodcastsInitial());

  void subScription() {
    emit(PodCastsLoading());
    repository.fetchSubscription().then((value) {
      if (value['err']) {
      } else {
        emit(PodcastsLoaded(subs: value['msg']));
      }
    });
  }

  void fetchPodcasts() {
    emit(PodCastsLoading());
    repository.podcasts().then((value) {
      if (value['err']) {
        emit(PodcastsError(msg: value['msg']));
      } else {
        emit(Pod(arts: value['msg']));
      }
    });
  }

  void arts() {
    emit(PodCastsLoading());
    repository.arts().then((value) {
      if (value['err']) {
        emit(PodcastsError(msg: value['msg']));
      } else {
        emit(Pod(arts: value['msg']));
      }
    });
  }

  void fetchEpisodes(var id) {
    emit(FetchingEpisodes());
    repository.episodes(id).then((value) {
      if (value['err']) {
        emit(PodcastsError(msg: value['msg']));
      } else {
        emit(FetchedEpisodes(episodes: value['msg']));
      }
    });
  }

  void fetchSingleEpisode() {
    emit(FetchingEpisodes());
  }

  void subscribe(var id) {
    emit(PodCastsLoading());
    repository.subscribe(id).then((value) {
      if (value['err']) {
        emit(PodcastsError(msg: value['msg']));
      } else {
        emit(PodcastSubscripted(msg: value['msg']));
      }
    });
  }
}
