part of 'new_trip_bloc.dart';

@immutable
abstract class NewTripState {}

class NewTripInitial extends NewTripState {}

class NewTripLoadingState extends NewTripState {}

class NewTripCompletedState extends NewTripState {
  final NewTripModel newTripModel;
  NewTripCompletedState({required this.newTripModel});
}

class NewTripErrorState extends NewTripState {
  final ErrorMessageClass error;
  NewTripErrorState({required this.error});
}
