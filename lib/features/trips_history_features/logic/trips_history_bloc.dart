import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:tripto_flutter/features/trips_history_features/model/trips_history_model.dart';
import 'package:tripto_flutter/features/trips_history_features/services/trips_api_repository.dart';

import '../../public_features/functions/error/error_exception.dart';
import '../../public_features/functions/error/error_message_class.dart';

part 'trips_history_event.dart';
part 'trips_history_state.dart';

class TripsHistoryBloc extends Bloc<TripsHistoryEvent, TripsHistoryState> {
  final TripsApiRepository tripsApiRepository;
  TripsHistoryBloc(this.tripsApiRepository) : super(TripsHistoryInitial()) {
    on<CallTripsHistoryEvent>((event, emit) async {
      emit(TripsHistoryLoadingState());
      try {
        TripsHistoryModel tripsHistoryModel = await tripsApiRepository.callTripsApiServices(event.tripId!);
        emit(TripsHistoryCompletedState(tripsHistoryModel: tripsHistoryModel));
      } on DioException catch (dioError) {
        emit(TripsHistoryErrorState(
          error: ErrorMessageClass(errorMsg: ErrorExceptions().fromError(dioError)),
        ));
      } catch (e) {
        emit(TripsHistoryErrorState(
          error: ErrorMessageClass(errorMsg: e.toString()),
        ));
      }
    });
  }
}
