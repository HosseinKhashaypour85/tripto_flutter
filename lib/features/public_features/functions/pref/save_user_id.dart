import 'package:shared_preferences/shared_preferences.dart';

class SaveUserId {
  Future<void> saveUserId(String id) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('userId', id);
  }

  Future<String?> getUserId() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString('userId');
  }
}
