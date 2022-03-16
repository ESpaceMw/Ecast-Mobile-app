import 'package:bloc/bloc.dart';
import 'package:ecast/Models/charts.dart';
import 'package:ecast/Services/repos/repo.dart';
import 'package:meta/meta.dart';

part 'charts_state.dart';

class ChartsCubit extends Cubit<ChartsState> {
  final Repository repository;

  ChartsCubit({required this.repository}) : super(ChartsInitial());

  void charts() {
    emit(ChartsLoading());
    repository.fetchCharts().then((value) {
      emit(ChartsLoaded(charts: value));
    });
  }
}
