import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeApiRepository {
  final Dio _dio = Dio();

  // تابع برای دریافت نام کاربر از سرور
  Future<String> getUserNameFromServer() async {
    final pref = await SharedPreferences.getInstance();
    final String? userId = pref.getString('userId');

    if (userId == null) {
      throw Exception('User ID not found');
    }

    final apiUrl = 'https://hosseinkhashaypour.chbk.app/api/collections/users/records/$userId';

    try {
      final response = await _dio.get(apiUrl);
      if (response.statusCode == 200) {
        final data = response.data;
        return data['name']; // فرض بر اینکه نام کاربر در فیلد 'name' قرار دارد
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      throw Exception('Error fetching user data: $e');
    }
  }
}
