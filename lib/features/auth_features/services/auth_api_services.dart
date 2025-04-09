import 'package:dio/dio.dart';
import 'package:tripto_flutter/features/public_features/functions/id_generator/id_generator.dart';
import 'package:tripto_flutter/features/public_features/functions/pref/save_user_id.dart';

class AuthApiServices {
  final Dio _dio = Dio();

  // sign in api
  Future<Response> callSignInAuthApi(String identity, String password) async {
    final apiUrl =
        'https://hosseinkhashaypour.chbk.app/api/collections/users/auth-with-password';
    final Response response = await _dio.post(
      apiUrl,
      data: {
        'identity': identity,
        'password': password,
      },
    );
    return response;
  }

//   sign up api
  Future<Response> callSignUpApi(
      String password, String passwordConfirm , String phoneNum , String userName) async {
    final apiUrl =
        'https://hosseinkhashaypour.chbk.app/api/collections/users/records';
    final String generateId = IdGenerator().idGenerator();
    final Response response = await _dio.post(
      apiUrl,
      data: {
        'id' : generateId,
        'name' : userName,
        'username' : phoneNum,
        'password': password,
        'passwordConfirm': passwordConfirm,
      },
    );
    if(response.statusCode == 200 || response.statusCode == 201){
      await SaveUserId().saveUserId(generateId);
    }
    return response;
  }
}
