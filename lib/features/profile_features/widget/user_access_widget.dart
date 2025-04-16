import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../const/shape/border_radius.dart';
import '../../../const/shape/media_query.dart';
import '../../../const/theme/colors.dart';
import '../../public_features/functions/secure_storage/secure_storage.dart';
import '../../public_features/screen/bottom_nav_screen.dart';
import '../../public_features/widget/snack_bar_widget.dart';

class UserAccessWidget extends StatefulWidget {
  const UserAccessWidget({super.key});

  @override
  State<UserAccessWidget> createState() => _UserAccessWidgetState();
}

class _UserAccessWidgetState extends State<UserAccessWidget> {
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
          _createMenuItem(
            title: 'لیست مسافران',
            icon: Icons.people,
            onTap: () {},
          ),
          _createMenuItem(
            title: 'علاقه مندی ها',
            icon: Icons.star,
            onTap: null,
          ),
          _createMenuItem(
            title: 'مرکز پشتیبانی',
            icon: Icons.question_mark,
            onTap: null,
          ),
          _createMenuItem(
            title: 'تماس با پشتیبانی',
            icon: Icons.call,
            onTap: null,
          ),
          _createMenuItem(
            title: 'درخواست پشتیبانی',
            icon: Icons.support_agent,
            onTap: null,
          ),
          _logOutMenuItem(
            title: 'خروج از حساب کاربری',
            icon: Icons.exit_to_app,
            onTap: () {
              SecureStorage().deleteUserToken();
              getSnackBarWidget(context, 'با موفقیت از حساب خارج شدید !', Colors.green);
              Navigator.pushNamedAndRemoveUntil(
                context,
                BottomNavBarScreen.screenId,
                    (route) => false,
              );
            },
          )
        ],
      ),
    );
  }
}

Widget _createMenuItem(
    {required String title,
      required IconData icon,
      required VoidCallback? onTap}) {
  return Column(
    children: [
      ListTile(
        leading: Icon(
          icon,
          color: primary2Color,
        ),
        onTap: onTap,
        trailing: Icon(Icons.arrow_forward),
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

Widget _logOutMenuItem(
    {required String title,
      required IconData icon,
      required VoidCallback? onTap}) {
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
