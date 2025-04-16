import 'package:dio/dio.dart';

class NotificationsApiServices {
  final Dio _dio = Dio();
  Future<Response>callNotificationsApi()async{
    final apiUrl = 'https://hosseinkhashaypour.chbk.app/api/collections/tripto_notifications/records/';
    final Response response = await _dio.get(apiUrl);
    return response;
  }
}