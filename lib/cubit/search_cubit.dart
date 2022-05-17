import 'package:bloc/bloc.dart';
import 'package:ecast/Services/repos/repo.dart';
import 'package:meta/meta.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  Repository repository;
  SearchCubit({required this.repository}) : super(SearchInitial());

  void searchOption() {
    emit(Searching());
  }

  void prev() {
    emit(SearchInitial());
  }
}
