part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}
class NavigateToProfileScreenSuccess extends HomeState {}
class HomeStateSuccess extends HomeState {
 final ProfileModel model;
  HomeStateSuccess(this.model);
}
class HomeStateFailure extends HomeState {

  final FailureError model;
  HomeStateFailure(this.model);

}
