import 'package:dio/dio.dart';
import 'package:tripto_flutter/features/public_features/functions/pref/save_trip_id.dart';
import 'package:tripto_flutter/features/public_features/functions/pref/save_user_id.dart';

class TripsApiServices {
  final Dio _dio = Dio();

  // Show trips history
  Future<Response?> callTripsApiServices() async {
    try {
      final apiUrl =
          'https://hosseinkhashaypour.chbk.app/api/collections/tripto_trips/records';
      final userId = await SaveUserId().getUserId();
      final tripId = await SaveTripId().getTripId();
      final response = await _dio.get(
        apiUrl,
        queryParameters: {'filter': 'trip_id = "$tripId"'},
      );
      return response;
    } on DioException catch (e) {
      print('! Dio error while fetching trip history: $e');
      throw e; // 🔁 دوباره پرتاب کن تا تو Repository مدیریت بشه
    } catch (e) {
      print('! Unknown error while fetching trip history: $e');
      throw Exception('خطای ناشناخته هنگام دریافت اطلاعات سفر');
    }
  }

  // Delete trips history by id
  Future<Response?> callDeleteHistoryApi(String id) async {
    try {
      final apiUrl =
          'https://hosseinkhashaypour.chbk.app/api/collections/tripto_trips/records/$id';
      final response = await _dio.delete(
        apiUrl,
        data: {
          'id': id,
        },
      );
      return response;
    } catch (e) {
      print('Error deleting trip history: $e');
      return null;
    }
  }
}
