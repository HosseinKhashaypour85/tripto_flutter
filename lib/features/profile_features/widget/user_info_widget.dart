import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../const/shape/border_radius.dart';
import '../../../const/shape/media_query.dart';
import '../../../const/theme/colors.dart';
import '../../public_features/functions/pref/save_phone_number.dart';

class UserInfoWidget extends StatefulWidget {
  const UserInfoWidget({super.key});

  @override
  State<UserInfoWidget> createState() => _UserInfoWidgetState();
}

class _UserInfoWidgetState extends State<UserInfoWidget> {
  String phoneNumber = '';

  @override
  void initState() {
    super.initState();
    _loadPhoneNumber();
  }

  void _loadPhoneNumber() async {
    String? getNumber = await getPhoneNumber();
    setState(() {
      phoneNumber = getNumber ?? '';
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.sp),
      padding: EdgeInsets.symmetric(vertical: 10.sp),
      decoration: BoxDecoration(
        borderRadius: getBorderRadiusFunc(10),
        border: Border.all(
          color: boxColors,
          width: 2.w,
        ),
      ),
      width: getWidth(
        context,
        getAllWidth(context),
      ),
      height: getHeight(context, 0.09),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 22.0.sp,
                    backgroundColor: boxColors,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 8.sp),
                  Text(
                    phoneNumber,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'irs',
                      fontSize: 15.sp,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'ویرایش اطلاعات',
                      style: TextStyle(
                        color: linkColor,
                        fontFamily: 'irs',
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: linkColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
