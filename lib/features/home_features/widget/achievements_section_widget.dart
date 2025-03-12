import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'achievements_items_widget.dart';

class AchievementsSectionWidget extends StatelessWidget {
  const AchievementsSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10.sp,
      children: [
        AchievementsItemsWidget(
          icon: Icons.confirmation_number,
          title: 'رتبه یک سفر',
          desc: 'معتبر ترین اپ برای سفر راحت تر',
        ),
        AchievementsItemsWidget(
          icon: Icons.devices,
          title: 'همسفر شما',
          desc: 'در حین سفر شما یک همسفر جهت راهنما خواهید داشت',
        ),
        AchievementsItemsWidget(
          icon: Icons.support_agent,
          title: 'پشتیبانی 24 ساعته',
          desc: 'در هروقت از زمان پشتیبانی در دسترس خواهد بود',
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 10.sp),
        ),
      ],
    );
  }
}
