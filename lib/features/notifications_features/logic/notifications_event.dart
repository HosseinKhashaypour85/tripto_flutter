part of 'notifications_bloc.dart';

@immutable
abstract class NotificationsEvent {}
class CallNotificationsEvent extends NotificationsEvent{}
class CallChangeNotificationsType extends NotificationsEvent{}
