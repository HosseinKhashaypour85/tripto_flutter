part of 'trips_history_bloc.dart';

@immutable
abstract class TripsHistoryEvent {}
class CallTripsHistoryEvent extends TripsHistoryEvent{
  final String? tripId;
  CallTripsHistoryEvent({required this.tripId});
}
