part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final RegisterModel model;

  LoginSuccess(this.model);
}

class LoginFailure extends LoginState {
  final FailureError failure;

  LoginFailure(this.failure);
}
