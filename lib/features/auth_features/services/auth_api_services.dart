import 'package:dio/dio.dart';

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
    final Response response = await _dio.post(
      apiUrl,
      data: {
        'name' : userName,
        'username' : phoneNum,
        'password': password,
        'passwordConfirm': passwordConfirm,
      },
    );
    return response;
  }
}
