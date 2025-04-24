part of 'new_trip_bloc.dart';

@immutable
abstract class NewTripEvent {}

class CallNewTripEvent extends NewTripEvent {
  final String originPlace;
  final String destinationPlace;
  final String tripPrice;
  final bool isRoundTrip;
  final String? tripId;

  CallNewTripEvent({
    required this.originPlace,
    required this.destinationPlace,
    required this.tripPrice,
    required this.isRoundTrip,
    required this.tripId
  });
}
