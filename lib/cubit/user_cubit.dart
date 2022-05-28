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
      if (res['err']) {
        emit(LoginError(error: res['msg']));
      } else {
        emit(LoginDone(
          msg: res['msg'],
        ));
      }
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

  void userProfile() {
    emit(Loading());
    repository.fetchUser().then((value) {
      if (value['err']) {
        emit(LoginError(error: value['msg']));
      } else {
        emit(FetchedUser(user: value['msg']));
      }
    });
  }

  void signout() {
    emit(logginout(msg: "Logging Out"));
    repository.logout().then((value) {
      if (value['err']) {
        if (value['type'] == 'net') {
          NetError(msg: value['msg']);
        } else {
          HttpError(msg: value['msg']);
        }
      } else {
        emit(Logout(msg: value['msg']));
      }
    });
  }

  void playlist() async {
    emit(FetchingPlaylist());
    repository.fetchPlaylist().then((value) {
      if (value['err']) {
        if (value['type'] == 'http') {
          emit(
            HttpError(
              msg: value['msg'],
            ),
          );
        } else {
          emit(
            NetError(
              msg: value['msg'],
            ),
          );
        }
      } else {
        emit(FetchedPlaylist(playlist: value['msg']));
      }
    });
  }

  void newPlaylist() async {
    emit(CreatingPlaylist());
    repository.createPlaylist().then((value) {
      if (value['err']) {
        if (value['type'] == 'http') {
          emit(HttpError(msg: value['msg']));
        } else {
          NetError(msg: value['msg']);
        }
      } else {
        emit(
          PlaylistCreated(
            msg: value['msg'],
          ),
        );
      }
    });
  }

  void resetPassword() {
    emit(ResettingPassword());
    repository.reset().then((value) {
      print(value);
      if (value['err']) {
        print(value);
      } else {
        emit(ResetDone());
      }
    });
  }
}
