import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tripto_flutter/const/theme/colors.dart';
import 'package:tripto_flutter/features/public_features/functions/pre_values/pre_values.dart';
import 'package:tripto_flutter/features/public_features/functions/secure_storage/secure_storage.dart';
import 'package:tripto_flutter/features/public_features/screen/bottom_nav_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../biometric_services_features/biometric_screen.dart';
import '../public_features/functions/secure_storage/check_biometric.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String screenId = 'splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void navigateFunc() async {
    bool isBiometricEnabled = await CheckBioSecureStorage().isBiometricEnabled();
    Timer(
      Duration(seconds: 3),
          () {
        Navigator.pushNamedAndRemoveUntil(
          context,
          isBiometricEnabled ? BiometricScreen.screenId : BottomNavBarScreen.screenId,
              (route) => false,
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    navigateFunc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: buttonColor,
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(PreValues().imageUrl),
                  SizedBox(height: 20.h),
                  Text(
                    'سفری راحت تر با تریپتو',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white,
                      fontFamily: 'irs'
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 30.h),
            child: FadeInDown(
              child: SpinKitFadingCube(
                color: Colors.white,
                size: 50.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
