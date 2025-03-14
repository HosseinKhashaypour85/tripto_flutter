part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class CallSignInEvent extends AuthEvent{
  final String? phoneNumber;
  final String? password;
  CallSignInEvent(this.phoneNumber, this.password);
}

class CallSignUpEvent extends AuthEvent{
  final String userName;
  final String phoneNumber;
  final String password;
  final String confirmPassword;
  CallSignUpEvent({required this.userName , required this.phoneNumber ,required this.password, required this.confirmPassword});
}