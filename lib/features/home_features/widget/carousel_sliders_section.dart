import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../const/shape/media_query.dart';
import '../logic/cubit/carousel_cubit.dart';

class CarouselSlidersSection extends StatefulWidget {
  const CarouselSlidersSection({super.key});

  @override
  State<CarouselSlidersSection> createState() => _CarouselSlidersSectionState();
}

class _CarouselSlidersSectionState extends State<CarouselSlidersSection> {
  List<Widget> adsSlidersWidget = [
    AdsSliderItems(image: 'assets/images/firstbanner.jpg'),
    AdsSliderItems(image: 'assets/images/secondbanner.jpg'),
    AdsSliderItems(image: 'assets/images/thirdbanner.jpg'),
    AdsSliderItems(image: 'assets/images/fourthbanner.jpg'),
  ];

  late PageController pageController;
  int _currentPage = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentPage < adsSlidersWidget.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: getAllWidth(context),
          height: getHeight(context, 0.3),
          child: PageView.builder(
            itemCount: adsSlidersWidget.length,
            controller: pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
                BlocProvider.of<CarouselCubit>(context).changeIndex(index);
              });
            },
            itemBuilder: (context, index) {
              return adsSlidersWidget[index];
            },
          ),
        ),
        SmoothPageIndicator(
          controller: pageController,
          count: adsSlidersWidget.length,
          onDotClicked: (index) {
            setState(() {
              _currentPage = index;
            });
            pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          },
          effect: const ExpandingDotsEffect(
            dotWidth: 10,
            dotHeight: 10,
            spacing: 5,
            activeDotColor: Colors.amber,
          ),
        ),
      ],
    );
  }
}

class AdsSliderItems extends StatelessWidget {
  const AdsSliderItems({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.sp),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.sp),
        child: GestureDetector(
          onTap: () async {
            final url = 'https://hosseinkhashaypour.ir';
            if (await canLaunchUrlString(url)) {
              await launchUrlString(url);
            }
          },
          child: Image.asset(
            image,
            width: getAllWidth(context),
          ),
        ),
      ),
    );
  }
}
