import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecast/Models/charts.dart';
import 'package:ecast/Services/repos/repo.dart';
import 'package:ecast/cubit/network_cubit.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'charts_state.dart';

class ChartsCubit extends Cubit<ChartsState> {
  final Repository repository;

  ChartsCubit({required this.repository}) : super(ChartsInitial());
  void charts() async {
    emit(ChartsLoading());

    try {
      var data = await http.get(Uri.parse('https://www.google.com'));
      if (data.statusCode == 200) {
        repository.fetchCharts().then((value) {
          emit(ChartsLoaded(charts: value['msg']));
        });
      }
    } on SocketException {
      emit(NetError(msg: "The internet and i are not talking at the moment"));
    } catch (e) {
      emit(NetError(msg: "The internet and i are not talking at the moment"));
    }
  }
}
