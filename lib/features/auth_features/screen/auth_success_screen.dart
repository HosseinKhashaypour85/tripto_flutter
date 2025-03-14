import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tripto_flutter/const/shape/border_radius.dart';
import 'package:tripto_flutter/const/theme/colors.dart';
import 'package:tripto_flutter/features/public_features/screen/bottom_nav_screen.dart';

import '../../../const/shape/media_query.dart';

class AuthSuccessScreen extends StatefulWidget {
  const AuthSuccessScreen({super.key, required this.phoneNumber});

  final String phoneNumber;

  @override
  State<AuthSuccessScreen> createState() => _AuthSuccessScreenState();
}

class _AuthSuccessScreenState extends State<AuthSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          spacing: 10.sp,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/success.png',
              width: getWidth(context, 0.7),
            ),
            Text(
              'ثبت نام شماره ${widget.phoneNumber} با موفقیت انجام شد',
              style: TextStyle(
                color: primary2Color,
                fontFamily: 'irs',
                fontSize: 16.sp,
              ),
            ),
            Text(
              'از پنل کاربری اقدام به ورود به پنل بکنید !',
              style: TextStyle(
                color: primary2Color,
                fontFamily: 'irs',
                fontSize: 16.sp,
              ),
            ),
            Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: getBorderRadiusFunc(10),
                ),
                fixedSize: Size(
                  getAllWidth(context) - 10,
                  getHeight(context, 0.06),
                ),
              ),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  BottomNavBarScreen.screenId,
                  (route) => false,
                );
              },
              child: Text(
                'بازگشت',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontFamily: 'irs',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: 5.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
