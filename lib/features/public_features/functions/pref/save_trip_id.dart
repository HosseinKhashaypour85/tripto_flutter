import 'package:shared_preferences/shared_preferences.dart';

class SaveTripId {
  Future<void>saveTripId(String id)async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('tripId', id);
    print('saved trip id $id');
  }
  Future<String?> getTripId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('tripId');
  }
}