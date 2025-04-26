import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../const/responsive.dart';
import '../../../const/shape/border_radius.dart';
import '../../../const/shape/media_query.dart';
import '../../../const/theme/colors.dart';
import '../../search_features/screen/search_screen.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getWidth(context, 0.02), vertical: 8.sp),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, ServiceSearchScreen.screenId ,);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: getWidth(context, 0.03)),
          height: Responsive.isTablet(context) ? 60 : 45,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: getBorderRadiusFunc(4),
          ),
          child: Row(
            children: [
              const Icon(Icons.search),
              SizedBox(width: getWidth(context, 0.01)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'جستجو خدمات ... ',
                    style: Responsive.isTablet(context)
                        ? TextStyle(
                            fontSize: 14.sp,
                            fontFamily: 'irs',
                            color: boxColors,
                          )
                        : TextStyle(
                            fontSize: 16.sp,
                            fontFamily: 'irs',
                            color: boxColors,
                          ),
                  ),
                  // Text(
                  //   'تریپتو',
                  //   style: TextStyle(
                  //     color: primaryColor,
                  //     fontFamily: 'irs',
                  //     fontSize: Responsive.isTablet(context) ? 15.sp : 18.sp,
                  //   ),
                  // ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
