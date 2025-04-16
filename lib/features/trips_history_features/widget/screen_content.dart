import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tripto_flutter/const/shape/media_query.dart';

import '../../../const/theme/colors.dart';
import '../../public_features/functions/number_to_three/number_to_three.dart';
import '../../public_features/widget/empty_screen_widget.dart';
import '../../public_features/widget/snack_bar_widget.dart';
import '../model/trips_history_model.dart';

class ScreenContent extends StatelessWidget {
  const ScreenContent({super.key, required this.tripsHistoryModel});

  final TripsHistoryModel tripsHistoryModel;

  @override
  Widget build(BuildContext context) {
    if (tripsHistoryModel.items!.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/no_trip.png',
              width: getWidth(
                context,
                0.3.sp,
              ),
            ),
            Text(
              'هنوز افتخار سفر با شما رو نداشته ایم !',
              style: TextStyle(
                fontFamily: 'irs',
                fontSize: 16.sp,
              ),
            )
          ],
        ),
      );
    }
    return GestureDetector(
      onTap: () {
        getSnackBarWidget(
            context, 'جهت اطلاع بیشتر دوبار کلیک کنید !', Colors.red);
      },
      onDoubleTap: () {
        /// navigate to info screen
        print('object');
      },
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: tripsHistoryModel.items!.length,
        itemBuilder: (context, index) {
          final helper = tripsHistoryModel.items![index];
          return Card(
            color: buttonColor,
            elevation: 3,
            margin: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 16.sp),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.sp),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(15.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'مبدا : ${helper.originPlace}',
                        style: TextStyle(
                          fontFamily: 'irs',
                          fontSize: 15.sp,
                        ),
                      ),
                      Text(
                        'مقصد  : ${helper.destinationPlace}',
                        style: TextStyle(
                          fontFamily: 'irs',
                          fontSize: 15.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'هزینه سفر  : ${'${getFormatPrice(helper.tripPrice.toString())}تومان'}',
                        style: TextStyle(
                          fontFamily: 'irs',
                          fontSize: 15.sp,
                        ),
                      ),
                      Text(
                        helper.roundTrip!
                            ? 'سفر دو طرفه بود'
                            : 'سفر یک طرفه بود',
                        style: TextStyle(
                          fontFamily: 'irs',
                          color: helper.roundTrip! ? Colors.black : Colors.red,
                          fontSize: 15.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
