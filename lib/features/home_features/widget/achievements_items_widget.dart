import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../const/theme/colors.dart';

class AchievementsItemsWidget extends StatelessWidget {
  const AchievementsItemsWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.desc,
  });

  final IconData icon;
  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.sp),
          child: IconButton(
            onPressed: () {},
            icon: Icon(
              icon,
              size: 28.sp,
              color: buttonColor,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 15.sp,
                fontFamily: 'irs',
              ),
            ),
            const SizedBox(height: 5),
            Text(
              desc,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey,
                fontFamily: 'irs',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
