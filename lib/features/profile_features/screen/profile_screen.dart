import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tripto_flutter/const/shape/border_radius.dart';
import 'package:tripto_flutter/const/shape/media_query.dart';
import 'package:tripto_flutter/const/theme/colors.dart';
import 'package:tripto_flutter/features/profile_features/widget/user_access_widget.dart';
import 'package:tripto_flutter/features/profile_features/widget/user_accounting_widget.dart';
import 'package:tripto_flutter/features/profile_features/widget/user_info_widget.dart';
import 'package:tripto_flutter/features/public_features/functions/pref/save_user_id.dart';
import 'package:tripto_flutter/features/public_features/functions/secure_storage/secure_storage.dart';
import 'package:tripto_flutter/features/public_features/screen/bottom_nav_screen.dart';
import 'package:tripto_flutter/features/public_features/widget/snack_bar_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static const String screenId = 'profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<void> showId() async {
    String? userId = await SaveUserId().getUserId();
    if (userId != null) {
      print('User ID: $userId');
    } else {
      print('No user ID found!');
    }
  }
 @override
  void initState() {
    super.initState();
    showId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10.sp),
                child: Row(
                  children: [
                    Text(
                      'حساب کاربری',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: 'irs',
                      ),
                    ),
                  ],
                ),
              ),
              UserInfoWidget(),
              UserAccountingWidget(),
              UserAccessWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
