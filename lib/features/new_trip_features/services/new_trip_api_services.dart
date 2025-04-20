import 'package:dio/dio.dart';

class NewTripApiServices {
  final Dio _dio = Dio();

  Future<Response> callNewTripApi({
    required String originPlace,
    required String destinationPlace,
    required bool isRound,
    required String tripPrice,
  }) async {
    final apiUrl =
        'https://hosseinkhashaypour.chbk.app/api/collections/tripto_trips/records';
    final Response response = await _dio.post(
      apiUrl,
      data: {
        'origin_place' : originPlace,
        'destination_place' : destinationPlace,
        'round_trip' : isRound,
        'trip_price' : tripPrice,
      },
    );
    return response;
  }
}
