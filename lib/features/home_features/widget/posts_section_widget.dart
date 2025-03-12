import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../const/shape/border_radius.dart';
import '../../../const/shape/media_query.dart';
import '../../../const/theme/colors.dart';
import '../../public_features/functions/pre_values/pre_values.dart';

class PostsSectionWidget extends StatelessWidget {
  const PostsSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getAllWidth(context),
      height: getHeight(context, 0.3),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 8,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              final url = 'https://hosseinkhashaypour.ir';
              if (await canLaunchUrlString(url)) {
                launchUrlString(url);
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: boxColors,
                borderRadius: getBorderRadiusFunc(10),
              ),
              width: getWidth(context, 0.5),
              height: getHeight(context, 0.5),
              margin: EdgeInsets.symmetric(horizontal: 10.sp),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    PreValues().imageUrl,
                    width: getAllWidth(context),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
