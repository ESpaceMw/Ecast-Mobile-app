import 'package:bloc/bloc.dart';
import 'package:ecast/Services/repos/repo.dart';
import 'package:meta/meta.dart';

part 'charts_state.dart';

class ChartsCubit extends Cubit<ChartsState> {
  final Repository repository;

  ChartsCubit({required this.repository}) : super(ChartsInitial());

  void charts() async {
    emit(ChartsLoading());
    repository.fetchCharts().then((value) {
      // print(value);
      if (value['err']) {
        if (value['type'] == 'net') {
          emit(NetError(msg: value['msg']));
        } else if (value['type'] == 'tkError') {
          emit(Exception(msg: value['msg']));
        } else {
          emit(HttpError(msg: value['msg']));
        }
      } else {
        emit(
          ChartsLoaded(
            charts: value['msg'],
            podcasts: value['pod'],
            playlists: value['playlists'],
            data: value['podcasts'],
          ),
        );
      }
    });
  }

  void fetchCharts() {
    emit(ChartsLoading());
    repository.fetchChartsData().then((value) {
      print(value);
      if (value['err']) {
        if (value['type'] == 'net') {
          emit(NetError(msg: value['msg']));
        } else {
          emit(HttpError(msg: value['msg']));
        }
      } else {
        emit(Charts(charts: value['msg']));
      }
    });
  }
}
