part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class LoginLoading extends UserState {}

class LoginDone extends UserState {
  final String msg;

  LoginDone({required this.msg});
}

class LoginError extends UserState {
  final String error;

  LoginError({required this.error});
}

class RegisteringUser extends UserState {}

class RegistrationDone extends UserState {
  final String msg;

  RegistrationDone({required this.msg});
}

class Loading extends UserState {}

class FetchedUser extends UserState {
  final Map user;

  FetchedUser({required this.user});
}

class logginout extends UserState {}

class Logout extends UserState {
  final String msg;

  Logout({required this.msg});
}
