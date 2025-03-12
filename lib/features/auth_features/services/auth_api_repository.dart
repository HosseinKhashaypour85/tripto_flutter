import 'package:dio/dio.dart';
import 'package:tripto_flutter/features/auth_features/services/auth_api_services.dart';

class AuthApiRepository {
  final AuthApiServices _apiServices = AuthApiServices();
  // sign in future
  Future<Response>callSignInAuthApi(String identity , String password)async{
    return await _apiServices.callSignInAuthApi(identity, password);
  }
}