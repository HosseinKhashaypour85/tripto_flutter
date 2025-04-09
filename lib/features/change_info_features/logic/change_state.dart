part of 'change_bloc.dart';

@immutable
abstract class ChangeState {}

class ChangeInitial extends ChangeState {}

class ChangeLoadingState extends ChangeState {}

class ChangeUserNameLoadedState extends ChangeState {
  final String userName;
  ChangeUserNameLoadedState(this.userName);
}

class ChangeErrorState extends ChangeState {
  final String errorMessage;
  ChangeErrorState(this.errorMessage);
}