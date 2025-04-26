import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tripto_flutter/const/shape/border_radius.dart';
import 'package:tripto_flutter/const/shape/media_query.dart';
import 'package:tripto_flutter/const/theme/colors.dart';
import 'package:tripto_flutter/features/public_features/functions/number_to_three/number_to_three.dart';
import 'package:tripto_flutter/features/public_features/screen/bottom_nav_screen.dart';

import '../widget/info_field_options_widget.dart';

class TripInfoScreen extends StatefulWidget {
  const TripInfoScreen({super.key});

  static const String screenId = 'trip_info';

  @override
  State<TripInfoScreen> createState() => _TripInfoScreenState();
}

class _TripInfoScreenState extends State<TripInfoScreen> {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String originCity = arguments['originCity'];
    final String destCity = arguments['destCity'];
    final int tripPrice = arguments['trip_price'];
    final bool isRoundTrip = arguments['isRoundTrip'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: buttonColor,
        title: Text(
          'جزئیات سفر',
          style: TextStyle(
            fontFamily: 'irs',
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            children: [
              // Flight header section
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(24.sp),
                margin: EdgeInsets.only(bottom: 24.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: getBorderRadiusFunc(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.airplanemode_active,
                      size: 64.sp,
                      color: buttonColor,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'پرواز ${isRoundTrip ? 'رفت و برگشت' : 'یک طرفه'}',
                      style: TextStyle(
                        fontFamily: 'irs',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          originCity,
                          style: TextStyle(
                            fontFamily: 'irs',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Icon(Icons.arrow_forward, size: 20.sp),
                        ),
                        Text(
                          destCity,
                          style: TextStyle(
                            fontFamily: 'irs',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Trip details section
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.sp),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: getBorderRadiusFunc(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'اطلاعات سفر',
                      style: TextStyle(
                        fontFamily: 'irs',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    buildInfoRow('مبدا', originCity),
                    Divider(height: 24.h, thickness: 0.5),
                    buildInfoRow('مقصد', destCity),
                    Divider(height: 24.h, thickness: 0.5),
                    buildInfoRow('نوع سفر', 'هواپیما'),
                    Divider(height: 24.h, thickness: 0.5),
                    buildInfoRow(
                      'هزینه سفر',
                      '${getFormatPrice(tripPrice.toString())} تومان',
                      isPrice: true,
                    ),
                  ],
                ),
              ),

              // Action button
              SizedBox(height: 24.h),
              Container(
                width: double.infinity,
                height: 48.h,
                decoration: BoxDecoration(
                  borderRadius: getBorderRadiusFunc(12),
                  gradient: LinearGradient(
                    colors: [buttonColor, Colors.blue.shade700],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    // Add your action here
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      BottomNavBarScreen.screenId,
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: getBorderRadiusFunc(12),
                    ),
                  ),
                  child: Text(
                    'تایید و ادامه',
                    style: TextStyle(
                      fontFamily: 'irs',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
