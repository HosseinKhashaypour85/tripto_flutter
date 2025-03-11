import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../const/shape/border_radius.dart';
import '../../../const/theme/colors.dart';

class ServicesIconWidget extends StatelessWidget {
  const ServicesIconWidget({
    super.key,
    required this.icon, required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // padding: EdgeInsets.all(5.sp),
          decoration: BoxDecoration(
            color: boxColors,
            borderRadius: getBorderRadiusFunc(5),
          ),
          child: IconButton(
            onPressed: () {},
            icon: Icon(
              icon,
              color: primary3Color,
              size: 40,
            ),
          ),
        ),
        SizedBox(height: 5.sp),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: 'irs',
          ),
        ),
      ],
    );
  }
}
