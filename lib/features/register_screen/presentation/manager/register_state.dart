part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final RegisterModel model;

  RegisterSuccess(this.model);
}

class RegisterFailure extends RegisterState {
  final FailureError failure;

  RegisterFailure(this.failure);
}
