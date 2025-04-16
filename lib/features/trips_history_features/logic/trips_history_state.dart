part of 'trips_history_bloc.dart';

@immutable
abstract class TripsHistoryState {}

class TripsHistoryInitial extends TripsHistoryState {}

class TripsHistoryLoadingState extends TripsHistoryState {}

class TripsHistoryCompletedState extends TripsHistoryState {
  final TripsHistoryModel tripsHistoryModel;
  TripsHistoryCompletedState({required this.tripsHistoryModel});
}

class TripsHistoryErrorState extends TripsHistoryState {
  final ErrorMessageClass error;
  TripsHistoryErrorState({required this.error});
}

