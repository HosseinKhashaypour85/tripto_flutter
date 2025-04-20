import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../const/shape/border_radius.dart';
import '../../../const/theme/colors.dart';
import '../../new_trip_features/screen/new_trip_screen.dart';

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({super.key});

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // navigate to new trip screen
        print('object');
        Navigator.pushNamed(context, NewTripScreen.screenId);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: getBorderRadiusFunc(10),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10.sp , vertical: 8.sp),
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
