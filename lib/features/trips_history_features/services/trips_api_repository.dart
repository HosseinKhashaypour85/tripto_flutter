import 'package:dio/dio.dart';
import 'package:tripto_flutter/features/trips_history_features/model/trips_history_model.dart';
import 'package:tripto_flutter/features/trips_history_features/services/trips_api_services.dart';

class TripsApiRepository {
  final TripsApiServices _apiServices = TripsApiServices();

  Future<TripsHistoryModel> callTripsApiServices() async {
    final Response response = await _apiServices.callTripsApiServices();
    TripsHistoryModel tripsHistoryModel =
        TripsHistoryModel.fromJson(response.data);
    return tripsHistoryModel;
  }
}
