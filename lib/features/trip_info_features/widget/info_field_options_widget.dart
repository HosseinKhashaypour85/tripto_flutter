import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../const/theme/colors.dart';

Widget buildInfoRow(String title, String value, {bool isPrice = false}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        value,
        style: TextStyle(
          fontFamily: 'irs',
          fontSize: 16.sp,
          fontWeight: isPrice ? FontWeight.bold : FontWeight.normal,
          color: isPrice ? buttonColor : Colors.grey.shade700,
        ),
      ),
      Text(
        title,
        style: TextStyle(
          fontFamily: 'irs',
          fontSize: 16.sp,
          color: Colors.grey.shade600,
        ),
      ),
    ],
  );
}
