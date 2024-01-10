part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}
class ProfileState extends HomeState {}
class ProfileStateSuccess extends HomeState {
 final ProfileModel model;
  ProfileStateSuccess(this.model);
}
class ProfileStateFailure extends HomeState {

  final FailureError model;
  ProfileStateFailure(this.model);

}
