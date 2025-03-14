import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:tripto_flutter/features/auth_features/services/auth_api_repository.dart';

import '../../public_features/functions/error/error_exception.dart';
import '../../public_features/functions/error/error_message_class.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthApiRepository repository;

  AuthBloc(this.repository) : super(AuthInitial()) {
    on<CallSignInEvent>(
      (event, emit) async {
        emit(SignInAuthLoadingState());
        try {
          final Response response = await repository.callSignInAuthApi(
              event.phoneNumber!, event.password!);
          final String? token = response.data['token'];
          emit(SignInAuthCompletedState(token));
        } on DioException catch (e) {
          emit(SignInAuthErrorState(
            ErrorMessageClass(errorMsg: ErrorExceptions().fromError(e)),
          ));
        }
      },
    );
    on<CallSignUpEvent>(
          (event, emit) async {
        emit(SignInAuthLoadingState());
        try {
          final Response response = await repository.callSignUpApi(event.password, event.confirmPassword , event.phoneNumber , event.userName);
          final String? token = response.data['token'];
          emit(SignUpAuthCompletedState(token));
        } on DioException catch (e) {
          emit(SignInAuthErrorState(
            ErrorMessageClass(errorMsg: ErrorExceptions().fromError(e)),
          ));
        }
      },
    );
  }
}
