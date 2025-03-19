import 'package:shared_preferences/shared_preferences.dart';

Future<void>savePhoneNumber(String phoneNum)async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  await pref.setString('phoneNum', phoneNum);
}

Future<String?>getPhoneNumber()async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('phoneNum');
}