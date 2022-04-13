import 'dart:async';
import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

part 'network_state.dart';

class NetworkCubit extends Cubit<NetworkState> {
  final Connectivity connectivity;

  late StreamSubscription<ConnectivityResult> connectivitySub;

  NetworkCubit({required this.connectivity}) : super(NetworkInitial()) {
    connectivitySub = connectivity.onConnectivityChanged.listen((result) async {
      // result = await Connectivity.Chec
      if (result == ConnectivityResult.none) {
        emit(NetworkDisconnected(msg: "No network connection"));
      } else {
        try {
          var data = await http.get(Uri.parse('https://www.google.com'));
          if (data.statusCode == 200) {
            emit(NetworkConnected());
          }
        } on SocketException {
          emit(NetworkDisconnected(
              msg: "The internet and i are not talking right now"));
        } catch (e) {
          emit(NetworkDisconnected(msg: "Error"));
        }
      }
    });
  }

  StreamSubscription<ConnectivityResult> moniterInt() {
    return connectivitySub =
        connectivity.onConnectivityChanged.listen((event) {});
  }

  void connected() => emit(NetworkConnected());
  void disconnected(String msg) => emit(NetworkDisconnected(msg: msg));

  @override
  Future<void> close() {
    connectivitySub.cancel();
    return super.close();
  }
}
