part of 'language_to_sign_cubit.dart';

@immutable
abstract class LanguageToSignState {}

class LanguageToSignInitial extends LanguageToSignState {}

class LanguageToSignLoading extends LanguageToSignState {}

class LanguageToSignSuccess extends LanguageToSignState {
  LanguageToSignModel model;

  LanguageToSignSuccess(this.model);
}

class LanguageToSignFailed extends LanguageToSignState {
  FailureError model;

  LanguageToSignFailed(this.model);
}
