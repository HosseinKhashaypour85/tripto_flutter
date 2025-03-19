import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../const/shape/border_radius.dart';
import '../../../const/shape/media_query.dart';
import '../../../const/theme/colors.dart';

class UserAccountingWidget extends StatefulWidget {
  const UserAccountingWidget({super.key});

  @override
  State<UserAccountingWidget> createState() => _UserAccountingWidgetState();
}

class _UserAccountingWidgetState extends State<UserAccountingWidget> {
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
                '0 تومان',
                style: TextStyle(
                  color: Colors.red,
                  fontFamily: 'irs',
                  fontSize: 15.sp,
                ),
              ),
            ],
          ),
          Divider(),
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
