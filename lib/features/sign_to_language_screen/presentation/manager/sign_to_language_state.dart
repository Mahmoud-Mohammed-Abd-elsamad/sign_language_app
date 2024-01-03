part of 'sign_to_language_cubit.dart';

@immutable
abstract class SignToLanguageState {}

class SignToLanguageInitial extends SignToLanguageState {}

class SignToLanguageTranslateLoading extends SignToLanguageState {}

class SignToLanguageTranslateSuccess extends SignToLanguageState {
  final SignToLanguageEntity model;

  SignToLanguageTranslateSuccess(this.model);
}

class SignToLanguageTranslateFailed extends SignToLanguageState {
  final FailureError model;

  SignToLanguageTranslateFailed(this.model);
}
