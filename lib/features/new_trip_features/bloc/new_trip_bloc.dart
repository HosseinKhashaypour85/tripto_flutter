import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:tripto_flutter/features/new_trip_features/model/new_trip_model.dart';
import 'package:tripto_flutter/features/new_trip_features/services/new_trip_api_repository.dart';
import 'package:tripto_flutter/features/public_features/functions/error/error_exception.dart';
import 'package:tripto_flutter/features/public_features/functions/error/error_message_class.dart';

part 'new_trip_event.dart';

part 'new_trip_state.dart';

class NewTripBloc extends Bloc<NewTripEvent, NewTripState> {
  final NewTripApiRepository newTripApiRepository;

  NewTripBloc(this.newTripApiRepository) : super(NewTripInitial()) {
    on<CallNewTripEvent>((event, emit) async {
      emit(NewTripLoadingState());
      try {
        NewTripModel newTripModel = await newTripApiRepository.callNewTripApi(
          event.originPlace,
          event.destinationPlace,
          event.isRoundTrip,
          event.tripPrice,
        );
        emit(NewTripCompletedState(newTripModel: newTripModel));
      } on DioException catch (e) {
        emit(
          NewTripErrorState(
            error: ErrorMessageClass(
              errorMsg: ErrorExceptions().fromError(e),
            ),
          ),
        );
      }
    });
  }
}
