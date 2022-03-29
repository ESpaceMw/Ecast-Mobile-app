import 'package:bloc/bloc.dart';
import 'package:ecast/Services/repos/repo.dart';
import 'package:meta/meta.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final Repository repository;

  UserCubit({required this.repository})
      : super(
          UserInitial(),
        );

  void login() {
    emit(LoginLoading());
    repository.signin().then((res) {
      if (res.toString() == "error") {
        emit(LoginError(error: "error"));
      }
      emit(LoginDone(
        msg: res,
      ));
    });
  }

  void register() {
    emit(RegisteringUser());
    repository.SignUp().then((value) {
      // final bool err? = value['err'];
      bool exists = value.containsKey('err');
      if (value['err']) {
        emit(LoginError(error: value['msg']));
      } else {
        emit(RegistrationDone(msg: value['msg']));
      }
    });
  }
}
