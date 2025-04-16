import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:tripto_flutter/features/notifications_features/model/notifications_model.dart';
import 'package:tripto_flutter/features/notifications_features/services/notifications_api_repository.dart';

import '../../public_features/functions/error/error_message_class.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final NotificationsApiRepository repository;
  NotificationsBloc(this.repository) : super(NotificationsInitial()) {
    // ایونت اول: CallNotificationsEvent
    on<CallNotificationsEvent>((event, emit) async {
      emit(NotificationsLoadingState());
      try {
        NotificationsModel notificationsModel = await repository.callNotificationsApi();
        emit(NotificationsCompletedState(notificationsModel: notificationsModel));
      } on DioException catch (e) {
        emit(NotificationsErrorState(
          error: ErrorMessageClass(errorMsg: "Unexpected Error: $e"),
        ));
      }
    });

    on<CallChangeNotificationsType>((event, emit) async {
      emit(NotificationsLoadingState());
      try {
        NotificationsModel notificationsModel = await repository.callNotificationsApi();
        emit(NotificationsCompletedState(notificationsModel: notificationsModel));
      } on DioException catch (e) {
        emit(NotificationsErrorState(
          error: ErrorMessageClass(errorMsg: "Unexpected Error: $e"),
        ));
      }
    });
  }
}
