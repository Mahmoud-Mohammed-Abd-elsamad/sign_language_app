part of 'reset_password_cubit.dart';

@immutable
abstract class ResetPasswordState {}

class ResetPasswordInitial extends ResetPasswordState {}

class ResetPasswordLoading extends ResetPasswordState {}

class ResetPasswordSuccess extends ResetPasswordState {
  final ResetPasswordModel model;

  ResetPasswordSuccess(this.model);
}

class ResetPasswordFailure extends ResetPasswordState {
  final FailureError failure;

  ResetPasswordFailure(this.failure);
}
