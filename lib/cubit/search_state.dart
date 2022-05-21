part of './search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class Searching extends SearchState {}

class SearchData extends SearchState {}

class SearchError extends SearchState {
  final String msg;

  SearchError({required this.msg});
}

class FetchedCat extends SearchState {
  final List categories;

  FetchedCat({required this.categories});
}
