import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tripto_flutter/features/public_features/functions/number_to_three/number_to_three.dart';
import 'package:tripto_flutter/features/trip_info_features/screen/trip_info_screen.dart';
import '../../../const/shape/border_radius.dart';
import '../../../const/shape/media_query.dart';
import '../../../const/theme/colors.dart';
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
          children: [
            Image.asset(
              'assets/images/no_trip.png',
              width: getWidth(context, 0.5),
              height: getWidth(context, 0.5),
            ),
            SizedBox(height: 24.h),
            Text(
              'هنوز سفری ثبت نشده است!',
              style: TextStyle(
                fontFamily: 'irs',
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade600,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'برای ثبت اولین سفر خود اقدام کنید',
              style: TextStyle(
                fontFamily: 'irs',
                fontSize: 14.sp,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      physics: const BouncingScrollPhysics(),
      itemCount: tripsHistoryModel.items!.length,
      separatorBuilder: (context, index) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        final trip = tripsHistoryModel.items![index];
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              TripInfoScreen.screenId,
              arguments: {
                'originCity': trip.originPlace,
                'destCity': trip.destinationPlace,
                'trip_price': trip.tripPrice,
                'isRoundTrip': trip.roundTrip,
              },
            );
          },
          onDoubleTap: () {
            getSnackBarWidget(
                context, 'اطلاعات بیشتر سفر نمایش داده شد', Colors.green);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: getBorderRadiusFunc(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(16.sp),
              child: Row(
                children: [
                  // Flight icon section
                  Container(
                    padding: EdgeInsets.all(12.sp),
                    decoration: BoxDecoration(
                      color: buttonColor.withOpacity(0.1),
                      borderRadius: getBorderRadiusFunc(8),
                    ),
                    child: Icon(
                      Icons.airplanemode_active,
                      color: buttonColor,
                      size: 28.sp,
                    ),
                  ),

                  SizedBox(width: 16.w),

                  // Trip info section
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Route info
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                trip.originPlace!,
                                style: TextStyle(
                                  fontFamily: 'irs',
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              child: Icon(
                                Icons.arrow_forward,
                                size: 18.sp,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                trip.destinationPlace!,
                                style: TextStyle(
                                  fontFamily: 'irs',
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 8.h),

                        // Trip details row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Trip type
                            Row(
                              children: [
                                Icon(
                                  Icons.repeat,
                                  size: 16.sp,
                                  color: Colors.grey.shade600,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  trip.roundTrip! ? 'رفت و برگشت' : 'یک طرفه',
                                  style: TextStyle(
                                    fontFamily: 'irs',
                                    fontSize: 12.sp,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),

                            // Price
                            Text(
                              '${getFormatPrice(
                                trip.tripPrice!.toString(),
                              )}تومان',
                              style: TextStyle(
                                fontFamily: 'irs',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: buttonColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Chevron icon
                  SizedBox(width: 8.w),
                  Icon(
                    Icons.chevron_left,
                    color: Colors.grey.shade400,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
