import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../const/shape/border_radius.dart';
import '../../../const/shape/media_query.dart';
import '../../../const/theme/colors.dart';
import '../../public_features/functions/pref/save_phone_number.dart';
import '../../user_charge_features/screen/user_charge_screen.dart'; // در صورتی که تابع نیاز باشد

class UserAccountingWidget extends StatefulWidget {
  const UserAccountingWidget({super.key});

  @override
  State<UserAccountingWidget> createState() => _UserAccountingWidgetState();
}

class _UserAccountingWidgetState extends State<UserAccountingWidget> {
  int currentCharge = 0;

  // تابع بارگذاری موجودی حساب
  Future<void> _loadAccountBalance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      currentCharge = prefs.getInt('account_balance') ?? 0; // اگر موجودی حساب یافت نشد، مقدار 0
    });
  }

  // تابع ذخیره موجودی حساب
  Future<void> _saveAccountBalance(int balance) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('account_balance', balance);
  }

  @override
  void initState() {
    super.initState();
    _loadAccountBalance(); // بارگذاری موجودی حساب هنگام بارگذاری صفحه
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.sp),
      padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 10.sp),
      decoration: BoxDecoration(
        borderRadius: getBorderRadiusFunc(10),
        border: Border.all(
          color: boxColors,
          width: 2.w,
        ),
      ),
      width: getAllWidth(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'موجودی حساب',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'irs',
                  fontSize: 15.sp,
                ),
              ),
              Text(
                currentCharge == 0
                    ? '0 تومان'
                    : '${currentCharge.toString()} تومان',
                style: TextStyle(
                  color: currentCharge == 0 ? Colors.red : Colors.green,
                  fontSize: 16,
                  fontFamily: 'irs',
                ),
              ),
            ],
          ),
          const Divider(),
          Row(
            children: [
              Icon(
                Icons.attach_money,
                color: Colors.green,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size(0, 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, AddBalanceScreen.screenId).then((_) {
                    _loadAccountBalance();
                  });
                },
                child: Text(
                  'افزایش موجودی',
                  style: TextStyle(
                    color: Colors.green,
                    fontFamily: 'irs',
                    fontSize: 15.sp,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
