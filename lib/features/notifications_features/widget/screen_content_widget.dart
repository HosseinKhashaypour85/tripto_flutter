import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tripto_flutter/features/notifications_features/model/notifications_model.dart';
import 'package:tripto_flutter/features/public_features/widget/empty_screen_widget.dart';

class NotificationsScreenContent extends StatelessWidget {
  const NotificationsScreenContent({
    super.key,
    required this.notificationsModel,
  });

  final NotificationsModel notificationsModel;

  @override
  Widget build(BuildContext context) {
    if (notificationsModel.items!.isEmpty) {
      return Center(
        child: EmptyWidget(
          title: 'اعلانی ندارید !',
          icon: Icons.notifications_none_rounded,
          subtitle: 'وقتی اعلان جدیدی داشته باشید اینجا ظاهر می‌شود',
        ),
      );
    }

    return ListView.builder(
      itemCount: notificationsModel.items!.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 8.sp),
      itemBuilder: (context, index) {
        final helper = notificationsModel.items![index];
        return Container(
          margin: EdgeInsets.symmetric(vertical: 6.sp, horizontal: 16.sp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.sp),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Material(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(14.sp),
            child: InkWell(
              borderRadius: BorderRadius.circular(14.sp),
              onTap: () {
                // Keep existing tap logic
              },
              child: Padding(
                padding: EdgeInsets.all(16.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(6.sp),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.notifications,
                            size: 18.sp,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        SizedBox(width: 10.sp),
                        Expanded(
                          child: Text(
                            helper.subject!,
                            style: TextStyle(
                              fontFamily: 'irs',
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).textTheme.titleMedium?.color,
                            ),
                          ),
                        ),
                        Text(
                          'امروز', // You can replace with actual date
                          style: TextStyle(
                            fontFamily: 'irs',
                            fontSize: 11.sp,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.sp),
                    Text(
                      helper.text!,
                      style: TextStyle(
                        fontFamily: 'irs',
                        fontSize: 13.sp,
                        color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.8),
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 4.sp),
                    Divider(
                      height: 24.sp,
                      thickness: 0.5,
                      color: Theme.of(context).dividerColor.withOpacity(0.2),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '${index + 1}/${notificationsModel.items!.length}',
                          style: TextStyle(
                            fontFamily: 'irs',
                            fontSize: 11.sp,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}