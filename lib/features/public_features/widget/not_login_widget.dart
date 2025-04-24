import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tripto_flutter/const/shape/media_query.dart';
import 'package:tripto_flutter/features/public_features/functions/pre_values/pre_values.dart';

class NotLoginWidget extends StatelessWidget {
  const NotLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 20.sp,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            PreValues().dontKnow,
            width: getWidth(context, 0.5.sp),
          ),
          Text(
            'لطفا ابتدا وارد حساب کاربری خود شوید !',
            style: TextStyle(
              fontFamily: 'irs',
            ),
          ),
        ],
      ),
    );
  }
}
