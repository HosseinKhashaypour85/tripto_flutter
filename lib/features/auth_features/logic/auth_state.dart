part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class SignInAuthLoadingState extends AuthState {}

class SignInAuthCompletedState extends AuthState {
  final String? token;

  SignInAuthCompletedState(this.token);
}

class SignInAuthErrorState extends AuthState {
  final ErrorMessageClass errorMessageClass;

  SignInAuthErrorState(this.errorMessageClass);
}

//Sign Up Logic
class SignUpAuthCompletedState extends AuthState{
  final String? token;
  SignUpAuthCompletedState(this.token);
}