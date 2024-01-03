part of 'history_cubit.dart';

@immutable
abstract class HistoryState {}

class HistoryInitial extends HistoryState {}
class HistoryLoading extends HistoryState {}
class HistorySuccess extends HistoryState {
  final HistoryModel model;
  HistorySuccess({required this.model});

}
class HistoryFailure extends HistoryState {
  final FailureError model;
  HistoryFailure({required this.model});

}
