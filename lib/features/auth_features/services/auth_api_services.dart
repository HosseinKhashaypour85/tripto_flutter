import 'package:dio/dio.dart';

class AuthApiServices {
  final Dio _dio = Dio();

  Future<Response> callSignInAuthApi(String identity , String password ) async {
    final apiUrl =
        'https://hosseinkhashaypour.chbk.app/api/collections/users/auth-with-password';
    final Response response = await _dio.post(
      apiUrl,
      data: {
        'identity' : identity,
        'password' : password,
      },
    );
    return response;
  }
}
