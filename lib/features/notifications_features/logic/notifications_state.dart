part of 'notifications_bloc.dart';

@immutable
abstract class NotificationsState {}

class NotificationsInitial extends NotificationsState {}

class NotificationsLoadingState extends NotificationsState {}

class NotificationsCompletedState extends NotificationsState {
  final NotificationsModel notificationsModel;
  NotificationsCompletedState({required this.notificationsModel});
}

class NotificationsErrorState extends NotificationsState {
  final ErrorMessageClass error;
  NotificationsErrorState({required this.error});
}
