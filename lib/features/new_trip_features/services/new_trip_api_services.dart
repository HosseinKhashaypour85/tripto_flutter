import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:tripto_flutter/features/public_features/functions/id_generator/trip_id_generator.dart';

class NewTripApiServices {
  final Dio _dio;

  NewTripApiServices({Dio? dio})
      : _dio = dio ??
      Dio(BaseOptions(
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ));

  // ایجاد سفر جدید
  Future<Response> callNewTripApi({
    required String originPlace,
    required String destinationPlace,
    required bool isRound,
    required String tripPrice,
  }) async {
    const String apiUrl =
        'https://hosseinkhashaypour.chbk.app/api/collections/tripto_trips/records';

    try {
      // خواندن شناسه سفر از SharedPreferences
      final String? savedTripId = await _getTripIdFromPrefs();

      // اگر شناسه سفر وجود ندارد، یک شناسه جدید تولید کنید
      String tripId = savedTripId ?? TripIdGenerator().tripIdGenerator();

      // اگر شناسه جدید تولید شد، آن را در SharedPreferences ذخیره کنید
      if (savedTripId == null) {
        await _saveTripIdToPrefs(tripId);
      }

      // ارسال درخواست API با شناسه سفر
      final response = await _dio.post(
        apiUrl,
        data: {
          'trip_id': tripId,
          'origin_place': originPlace,
          'destination_place': destinationPlace,
          'round_trip': isRound,
          'trip_price': tripPrice,
        },
      );

      return response;
    } catch (e) {
      print('خطا هنگام ارسال درخواست: $e');
      rethrow;
    }
  }

  // ذخیره شناسه سفر در SharedPreferences
  Future<void> _saveTripIdToPrefs(String tripId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('tripId', tripId);
  }

  // خواندن شناسه سفر از SharedPreferences
  Future<String?> _getTripIdFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('tripId');
  }
}
