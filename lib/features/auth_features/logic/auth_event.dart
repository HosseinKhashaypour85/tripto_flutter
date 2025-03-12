part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class CallSignInEvent extends AuthEvent{
  final String? phoneNumber;
  final String? password;
  CallSignInEvent(this.phoneNumber, this.password);
}
