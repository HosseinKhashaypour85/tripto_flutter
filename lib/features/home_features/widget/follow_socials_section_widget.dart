import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../const/theme/colors.dart';

class FollowSocialsSectionWidget extends StatelessWidget {
  const FollowSocialsSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'تریپتو را در شبکه های اجتماعی دنبال کنید :',
          style: TextStyle(
            color: boxColors,
            fontFamily: 'irs',
          ),
        ),
        SizedBox(
          height: 20.sp,
        ),
        Row(
          spacing: 20.sp,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              FontAwesomeIcons.twitter,
              color: primary2Color,
              size: 40.sp,
            ),
            Icon(
              FontAwesomeIcons.telegram,
              color: primary2Color,
              size: 40.sp,
            ),
            Icon(
              FontAwesomeIcons.instagram,
              color: primary2Color,
              size: 40.sp,
            ),
          ],
        ),
        SizedBox(
          height: 20.sp,
        ),
      ],
    );
  }
}
