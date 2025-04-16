import 'package:dio/dio.dart';

class TripsApiServices {
  final Dio _dio = Dio();

//   show trips history
  Future<Response> callTripsApiServices() async {
    final apiUrl =
        'https://hosseinkhashaypour.chbk.app/api/collections/tripto_trips/records';
    final Response response = await _dio.get(apiUrl);
    return response;
  }
}
