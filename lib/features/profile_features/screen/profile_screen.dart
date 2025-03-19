import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tripto_flutter/const/shape/border_radius.dart';
import 'package:tripto_flutter/const/shape/media_query.dart';
import 'package:tripto_flutter/const/theme/colors.dart';
import 'package:tripto_flutter/features/profile_features/widget/user_accounting_widget.dart';
import 'package:tripto_flutter/features/profile_features/widget/user_info_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static const String screenId = 'profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // List<Widget> userAccessWidget = [
  //   UserAccessOptions(
  //     icon: Icons.add,
  //     title: 'title',
  //   ),UserAccessOptions(
  //     icon: Icons.add,
  //     title: 'title',
  //   ),UserAccessOptions(
  //     icon: Icons.add,
  //     title: 'title',
  //   ),
  // ];

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
              Container(
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
                      onTap: () {

                      },
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
                      title: 'درخواست پشتیبانی',
                      icon: Icons.support_agent,
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
                      onTap: null,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
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
        Divider(),
      ],
    ),
  );
}
