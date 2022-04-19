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
      if (value['err']) {
        if (value['type'] == 'net') {
          emit(NetError(msg: value['msg']));
        } else {
          emit(HttpError(msg: value['msg']));
        }
      } else {
        emit(ChartsLoaded(charts: value['msg'], podcasts: value['pod']));
      }
    });
  }
}
