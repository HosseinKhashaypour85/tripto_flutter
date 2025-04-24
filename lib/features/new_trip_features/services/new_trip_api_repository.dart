import 'package:dio/dio.dart';
import 'package:tripto_flutter/features/new_trip_features/model/new_trip_model.dart';
import 'package:tripto_flutter/features/new_trip_features/services/new_trip_api_services.dart';

class NewTripApiRepository {
  final NewTripApiServices _apiServices = NewTripApiServices();

  Future<NewTripModel> callNewTripApi(String originPlace,
      String destinationPlace, bool isRound, String tripPrice, String tripId) async {
    try {
      final Response response = await _apiServices.callNewTripApi(
        originPlace: originPlace,
        destinationPlace: destinationPlace,
        isRound: isRound,
        tripPrice: tripPrice,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        NewTripModel newTripModel = NewTripModel.fromJson(response.data);
        return newTripModel;
      } else {
        throw Exception('خطای دریافت اطلاعات از سرور');
      }
    } catch (e) {
      print('خطای درخواست: $e');
      throw Exception('خطای در ارسال درخواست به سرور');
    }
  }
}
