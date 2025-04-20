import 'package:dio/dio.dart';
import 'package:tripto_flutter/features/new_trip_features/model/new_trip_model.dart';
import 'package:tripto_flutter/features/new_trip_features/services/new_trip_api_services.dart';

class NewTripApiRepository {
  final NewTripApiServices _apiServices = NewTripApiServices();

  Future<NewTripModel> callNewTripApi(String originPlace,
      String destinationPlace, bool isRound, String tripPrice) async {
    final Response response = await _apiServices.callNewTripApi(
      originPlace: originPlace,
      destinationPlace: destinationPlace,
      isRound: isRound,
      tripPrice: tripPrice,
    );
    NewTripModel newTripModel = NewTripModel.fromJson(response.data);
    return newTripModel;
  }
}
