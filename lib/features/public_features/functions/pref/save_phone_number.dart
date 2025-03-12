import 'package:shared_preferences/shared_preferences.dart';

Future<void>savePhoneNumber(String phoneNum)async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  await pref.setString('phoneNum', phoneNum);
}

Future<void>getPhoneNumber(String phoneNum)async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  await pref.getString('phoneNum');
}