part of 'token_check_cubit.dart';

@immutable
abstract class TokenCheckState {}

class TokenCheckInitial extends TokenCheckState {}

class TokenLoggedState extends TokenCheckState {}

class TokenNotLoggedState extends TokenCheckState {}
