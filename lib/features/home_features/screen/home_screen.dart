import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tripto_flutter/const/shape/border_radius.dart';
import 'package:tripto_flutter/const/theme/colors.dart';
import 'package:tripto_flutter/features/public_features/widget/search_bar_widget.dart';
import 'package:tripto_flutter/features/public_features/widget/snack_bar_widget.dart';

import '../widget/services_icon_widget.dart';
import '../widget/services_section_widget.dart';
import '../widget/top_section_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String screenId = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          spacing: 10.sp,
          children: [
            TopSectionWidget(),
            ServicesSection(),
            SizedBox(
              height: 30.sp,
            ),
            Padding(
              padding: EdgeInsets.all(10.sp),
              child: Image.asset(
                'assets/images/firstbanner.jpg',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
