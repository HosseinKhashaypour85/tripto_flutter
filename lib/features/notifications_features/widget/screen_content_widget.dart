import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tripto_flutter/features/notifications_features/model/notifications_model.dart';
import 'package:tripto_flutter/features/public_features/widget/empty_screen_widget.dart';

import '../../../const/theme/colors.dart';

class ScreenContent extends StatelessWidget {
  const ScreenContent({super.key, required this.notificationsModel});

  final NotificationsModel notificationsModel;

  @override
  Widget build(BuildContext context) {
    if (notificationsModel.items!.isEmpty) {
      return Center(
        child: EmptyWidget(title: 'اعلانی ندارید !'),
      );
    }
    return ListView.builder(
      itemCount: notificationsModel.items!.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final helper = notificationsModel.items![index];
        return Card(
          color: buttonColor,
          elevation: 5,
          margin: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 16.sp),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.sp),
          ),
          child: Padding(
            padding: EdgeInsets.all(10.sp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10.sp,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.notifications,
                      size: 18.sp,
                      color: linkColor,
                    ),
                    SizedBox(
                      width: 4.sp,
                    ),
                    Text(
                      helper.subject!,
                      style: TextStyle(
                        fontFamily: 'irs',
                        fontSize: 15.sp,
                      ),
                    ),
                  ],
                ),
                Text(
                  helper.text!,
                  style: TextStyle(
                    fontFamily: 'irs',
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
