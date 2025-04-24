import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tripto_flutter/features/public_features/functions/pref/save_trip_id.dart';
import 'package:tripto_flutter/features/public_features/functions/pref/save_user_id.dart';
import 'package:tripto_flutter/features/public_features/widget/snack_bar_widget.dart';

import '../../../const/shape/border_radius.dart';
import '../../../const/theme/colors.dart';
import '../../new_trip_features/screen/new_trip_screen.dart';

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({super.key});

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  Response? tripsData;

  // بارگذاری داده‌های سفر
  Future<void> loadTrips() async {
    try {
      final Dio dio = Dio();
      final apiUrl =
          'https://hosseinkhashaypour.chbk.app/api/collections/tripto_trips/records';
      final userId = await SaveUserId().getUserId();
      final tripId = await SaveTripId().getTripId();

      // if (userId == null) {
      //   getSnackBarWidget(context, 'ابتدا وارد حساب کاربری شوید !', Colors.red);
      // }

      // ارسال درخواست به API برای گرفتن داده‌ها بر اساس tripId
      final Response response = await dio.get(
        apiUrl,
        queryParameters: {'filter': 'trip_id = "$tripId"'},
      );

      // به‌روزرسانی وضعیت با داده‌های جدید
      setState(() {
        tripsData = response;
      });
    } catch (e) {
      print('Error fetching trips: $e');
      getSnackBarWidget(context, 'خطا در دریافت داده‌ها', Colors.red);
    }
  }

  @override
  void initState() {
    super.initState();
    loadTrips();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // navigate to new trip screen
        Navigator.pushNamed(context, NewTripScreen.screenId).then((_) {
          // بعد از برگشت از صفحه جدید داده‌ها را دوباره بارگذاری کنیم
          loadTrips();
          setState(() {
            loadTrips();
          });
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: getBorderRadiusFunc(10),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 8.sp),
        margin: EdgeInsets.symmetric(horizontal: 10.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'سفر جدید',
              style: TextStyle(
                fontFamily: 'irs',
              ),
            ),
            Icon(
              Icons.add,
              color: buttonColor,
            )
          ],
        ),
      ),
    );
  }
}
