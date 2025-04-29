import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tripto_flutter/features/public_features/functions/secure_storage/secure_storage.dart';
import 'package:tripto_flutter/features/public_features/widget/snack_bar_widget.dart';

import '../../../const/shape/border_radius.dart';
import '../../../const/shape/media_query.dart';
import '../../../const/theme/colors.dart';
import '../../public_features/functions/secure_storage/check_biometric.dart';

class UserAccessWidget extends StatefulWidget {
  const UserAccessWidget({super.key});

  @override
  State<UserAccessWidget> createState() => _UserAccessWidgetState();
}

class _UserAccessWidgetState extends State<UserAccessWidget> {
  bool _isBiometricEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadBiometricSetting();
  }

  void _loadBiometricSetting() async {
    _isBiometricEnabled = await CheckBioSecureStorage().isBiometricEnabled();
    setState(() {});
  }

  void _toggleBiometricSetting() async {
    _isBiometricEnabled = !_isBiometricEnabled;
    await CheckBioSecureStorage().saveBiometricEnabled(_isBiometricEnabled);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getAllWidth(context),
      height: getHeight(context, 0.5.sp),
      margin: EdgeInsets.all(10.sp),
      padding: EdgeInsets.symmetric(vertical: 10.sp),
      decoration: BoxDecoration(
        borderRadius: getBorderRadiusFunc(10),
        border: Border.all(
          color: boxColors,
          width: 2.w,
        ),
      ),
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          // Biometric Setting
          _createMenuItem(
            title: 'فعال کردن رمز عبور بیومتریک',
            icon: Icons.fingerprint,
            onTap: _toggleBiometricSetting,
            trailing: Switch(
              focusColor: buttonColor,
              activeColor: buttonColor,
              inactiveTrackColor: Colors.red.shade400,
              value: _isBiometricEnabled,
              onChanged: (value) {
                _toggleBiometricSetting();
              },
            ),
          ),
          // Other Menu Items
          _createMenuItem(
            title: 'لیست مسافران',
            icon: Icons.people,
            onTap: () {
              // Add navigation or functionality here
            },
          ),
          _createMenuItem(
            title: 'علاقه مندی ها',
            icon: Icons.star,
            onTap: () {
              // Add navigation or functionality here
            },
          ),
          _createMenuItem(
            title: 'مرکز پشتیبانی',
            icon: Icons.question_mark,
            onTap: () {
              // Add navigation or functionality here
            },
          ),
          _createMenuItem(
            title: 'تماس با پشتیبانی',
            icon: Icons.call,
            onTap: () {
              // Add navigation or functionality here
            },
          ),
          // _createMenuItem(
          //   title: 'درخواست پشتیبانی',
          //   icon: Icons.support_agent,
          //   onTap: () {
          //     // Add navigation or functionality here
          //   },
          // ),
          _logOutMenuItem(
            title: 'خروج از حساب کاربری',
            icon: Icons.exit_to_app,
            onTap: () {
              // Log out functionality
              CheckBioSecureStorage().deleteUserToken();
              SecureStorage().deleteUserToken();
              getSnackBarWidget(context, 'با موفقیت از حساب خارج شدید!', Colors.red);
              // Redirect to a screen after logout
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/home', // Replace with the actual route name
                    (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _createMenuItem({
    required String title,
    required IconData icon,
    required VoidCallback? onTap,
    Widget? trailing,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            icon,
            color: primary2Color,
          ),
          onTap: onTap,
          trailing: trailing ?? Icon(Icons.arrow_forward),
          title: Text(
            title,
            style: TextStyle(
              color: primary2Color,
              fontSize: 15.sp,
              fontFamily: 'irs',
            ),
          ),
        ),
        Divider()
      ],
    );
  }

  Widget _logOutMenuItem({
    required String title,
    required IconData icon,
    required VoidCallback? onTap,
  }) {
    return Padding(
      padding: EdgeInsets.all(8.sp),
      child: Column(
        children: [
          ListTile(
            leading: Icon(
              icon,
              color: Colors.red,
            ),
            onTap: onTap,
            trailing: Icon(Icons.arrow_forward),
            title: Text(
              title,
              style: TextStyle(
                color: Colors.red,
                fontSize: 15.sp,
                fontFamily: 'irs',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
