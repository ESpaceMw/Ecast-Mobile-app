import 'package:bloc/bloc.dart';
import 'package:ecast/Services/repos/repo.dart';
import 'package:meta/meta.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  Repository repository;
  SearchCubit({required this.repository}) : super(SearchInitial());

  void searchOption() {
    emit(SearchMode());
  }

  void prev() {
    emit(SearchInitial());
    categories();
  }

  void categories() {
    emit(Searching());
    repository.cats().then((value) {
      if (value['err']) {
        emit(
          SearchError(msg: "Error fetching data"),
        );
      } else {
        emit(
          FetchedCat(
            categories: value['msg'],
          ),
        );
      }
    });
  }

  void filterPodcasts(title) {
    emit(Searching());
    repository.filter(title).then((value) {
      if (value['err']) {
        if (value['type'] == 'net') {
          emit(NetError());
        } else {
          emit(HttpErr());
        }
      } else {
        emit(
          FetchedCat(
            categories: value['msg'],
          ),
        );
      }
    });
  }

  void searchPodcast(title) {
    emit(Searching());
    repository.search(title).then((value) {
      if (value['err']) {
        if (value['type'] == 'net') {
          emit(NetError());
        } else {
          emit(HttpErr());
        }
      } else {
        emit(
          SearchResults(
            results: value['msg'],
          ),
        );
      }
    });
  }
}
