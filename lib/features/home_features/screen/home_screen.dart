import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tripto_flutter/const/shape/border_radius.dart';
import 'package:tripto_flutter/const/shape/media_query.dart';
import 'package:tripto_flutter/const/theme/colors.dart';
import 'package:tripto_flutter/features/home_features/logic/cubit/carousel_cubit.dart';
import 'package:tripto_flutter/features/public_features/functions/pre_values/pre_values.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../widget/achievements_items_widget.dart';
import '../widget/achievements_section_widget.dart';
import '../widget/carousel_sliders_section.dart';
import '../widget/follow_socials_section_widget.dart';
import '../widget/posts_section_widget.dart';
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            spacing: 20.sp,
            children: [
              const TopSectionWidget(),
              const ServicesSection(),
              const CarouselSlidersSection(),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.sp,
                    ),
                    child: Text(
                      'پست های اخیر تریپتو',
                      style: TextStyle(
                        fontFamily: 'irs',
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                ],
              ),
              const PostsSectionWidget(),
              const AchievementsSectionWidget(),
              const FollowSocialsSectionWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

