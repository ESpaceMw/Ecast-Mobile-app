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
      emit(PodcastsLoaded(subs: value));
    });
  }
}
