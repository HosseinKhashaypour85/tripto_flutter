import 'package:tripto_flutter/features/trips_history_features/services/trips_api_services.dart';

import '../model/trips_history_model.dart';

class TripsApiRepository {
  final TripsApiServices tripsApiServices = TripsApiServices();

  Future<TripsHistoryModel> callTripsApiServices(String tripId) async {
    final response = await tripsApiServices.callTripsApiServices();

    if (response != null && response.statusCode == 200 && response.data != null) {
      return TripsHistoryModel.fromJson(response.data);
    } else {
      throw Exception('سفر پیدا نشد یا سرور پاسخ نداد');
    }
  }
}
