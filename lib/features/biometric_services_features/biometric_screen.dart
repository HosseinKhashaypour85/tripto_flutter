import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_auth/local_auth.dart';
import 'package:tripto_flutter/features/public_features/screen/bottom_nav_screen.dart';
import '../../const/shape/media_query.dart';

class BiometricScreen extends StatefulWidget {
  const BiometricScreen({super.key});

  static const String screenId = 'biometric';

  @override
  State<BiometricScreen> createState() => _BiometricScreenState();
}

class _BiometricScreenState extends State<BiometricScreen> {
  final LocalAuthentication _auth = LocalAuthentication();
  bool _isAuthenticated = false;
  bool _isLoading = false;
  bool _showWelcome = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => _showWelcome = true);
      _authenticate();
    });
  }

  Future<void> _authenticate() async {
    setState(() => _isLoading = true);
    try {
      if (!_isAuthenticated) {
        final bool canAuthWithBios = await _auth.canCheckBiometrics;
        if (canAuthWithBios) {
          final bool didAuthSuccess = await _auth.authenticate(
            localizedReason: 'لطفا هویت خود را تأیید کنید',
            options: const AuthenticationOptions(biometricOnly: false),
          );
          if (didAuthSuccess) {
            setState(() => _isAuthenticated = true);
            Future.delayed(const Duration(milliseconds: 800), () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                BottomNavBarScreen.screenId,
                    (route) => false,
              );
            });
          }
        }
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 80.h),
              // Animated fingerprint icon
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                width: 120.w,
                height: 120.w,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue[50]!,
                      Colors.blue[100]!,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.2),
                      blurRadius: 15,
                      spreadRadius: 2,
                    )
                  ],
                ),
                child: Center(
                  child: Icon(
                    Icons.fingerprint,
                    size: 60.sp,
                    color: Colors.blue[800],
                  ),
                ),
              ),
              SizedBox(height: 40.h),
              // Welcome message
              AnimatedOpacity(
                opacity: _showWelcome ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 700),
                child: Column(
                  children: [
                    Text(
                      'خوش آمدید',
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900],
                        fontFamily: 'irs',
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'برای ورود به حساب کاربری خود احراز هویت کنید',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.grey[600],
                        fontFamily: 'irs',
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              // Authentication status indicator
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _isAuthenticated
                    ? Column(
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 40.sp,
                      color: Colors.green,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'احراز هویت موفق',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'irs',
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                )
                    : SizedBox(height: 80.h),
              ),
              // Authentication Button
              _buildAuthButton(),
              SizedBox(height: 60.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAuthButton() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: getAllWidth(context) * 0.9,
        height: 56.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28.r),
          boxShadow: [
            if (!_isLoading && !_isAuthenticated)
              BoxShadow(
                color: Colors.blue.withOpacity(0.3),
                blurRadius: 10,
                spreadRadius: 2,
              ),
          ],
        ),
        child: ElevatedButton(
          onPressed: _isLoading ? null : _authenticate,
          style: ElevatedButton.styleFrom(
            backgroundColor: _isAuthenticated ? Colors.green : Colors.blue[600],
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28.r),
            ),
            elevation: 0,
            padding: EdgeInsets.symmetric(horizontal: 24.w),
          ),
          child: _isLoading
              ? SizedBox(
            width: 24.w,
            height: 24.w,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: Colors.white,
            ),
          )
              : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _isAuthenticated ? Icons.check : Icons.fingerprint,
                size: 24.sp,
              ),
              SizedBox(width: 12.w),
              Text(
                _isAuthenticated
                    ? 'در حال انتقال...'
                    : 'احراز هویت بیومتریک',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'irs',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}