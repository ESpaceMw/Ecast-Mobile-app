import 'package:bloc/bloc.dart';
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

  void subscribe(id) {
    emit(SubProcess());
    repository.subscribes(id).then((value) {
      if (value['err']) {
        emit(PodcastsError(msg: value['msg']));
      } else {
        emit(PodcastSubscripted(msg: value['msg'].toString()));
      }
    });
  }

  void unsubscribe(id) {
    emit(SubProcess());
    repository.unsubscribe(id).then((value) {
      if (value['err']) {
        emit(PodcastsError(msg: value['msg']));
      } else {
        emit(Unsubscribed(msg: value['msg'].toString()));
      }
    });
  }

  void fetchPlaylists() async {
    emit(SubProcess());
    repository.fetchAdminPlaylists().then((value) {
      if (value['err']) {
        emit(
          PodcastsError(
            msg: value['msg'],
          ),
        );
      } else {
        emit(
          PlaylistsFetched(
            playlists: value['msg'],
          ),
        );
      }
    });
  }

  void fetchRelatedPodcasts() {
    emit(SubProcess());
  }
}
