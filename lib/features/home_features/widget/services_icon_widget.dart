import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tripto_flutter/features/new_trip_features/screen/new_trip_screen.dart';

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
            color: Colors.white,
            borderRadius: getBorderRadiusFunc(5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(2, 4),
              ),
            ],
          ),
          child: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, NewTripScreen.screenId,);
            },
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
