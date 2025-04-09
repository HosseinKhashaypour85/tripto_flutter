import 'package:shared_preferences/shared_preferences.dart';

class UserCharge {
  // ذخیره موجودی حساب در SharedPreferences
  Future<void> saveAccountBalance(int balance) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('account_balance', balance);
  }

  // بارگذاری موجودی حساب از SharedPreferences
  Future<int> getAccountBalance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('account_balance') ?? 0; // اگر هیچ مقداری موجود نبود، مقدار 0 بر می‌گردد.
  }
}
