import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tripto_flutter/const/shape/media_query.dart';
import 'package:tripto_flutter/const/theme/colors.dart';
import 'package:tripto_flutter/const/shape/border_radius.dart';
import 'package:tripto_flutter/features/new_trip_features/screen/new_trip_screen.dart';
import 'package:tripto_flutter/features/public_features/widget/snack_bar_widget.dart';

class ServiceSearchScreen extends StatefulWidget {
  const ServiceSearchScreen({super.key});

  static const String screenId = 'search';

  @override
  State<ServiceSearchScreen> createState() => _ServiceSearchScreenState();
}

class _ServiceSearchScreenState extends State<ServiceSearchScreen> {
  void _navigate() {
    Timer(
      Duration(seconds: 4),
      () => Navigator.pushNamed(context, NewTripScreen.screenId),
    );
  }
  final String snackBarMsg =
      'فعلا امکان خرید بلیط رو از تریپتو رو دارید ! درحال انتقال به صفحه خرید بلیط هستید...';


  final TextEditingController _searchController = TextEditingController();
  List<String> _recentSearches = [
    'هتل در تهران',
    'تور کیش',
    'رستوران مشهد',
    'اجاره ماشین'
  ];
  List<String> _popularServices = [
    'رزرو هتل',
    'بلیط هواپیما',
    'تور داخلی',
    'رستوران',
    'اجاره ویلا',
    'بلیط قطار'
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: buttonColor,
        title: Text(
          'جستجوی خدمات',
          style: TextStyle(
              fontFamily: 'irs', fontSize: 18.sp, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            children: [
              // Search Bar
              _buildSearchBar(),
              SizedBox(height: 24.h),

              // Recent Searches
              if (_recentSearches.isNotEmpty) ...[
                _buildSectionTitle('جستجوهای اخیر'),
                SizedBox(height: 8.h),
                _buildRecentSearches(),
                SizedBox(height: 24.h),
              ],

              // Popular Services
              _buildSectionTitle('خدمات پرطرفدار'),
              SizedBox(height: 8.h),
              _buildPopularServices(),
              // Spacer(),
              // ElevatedButton(
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: buttonColor,
              //     fixedSize: Size(
              //       getAllWidth(context),
              //       getHeight(context, 0.05.sp),
              //     ),
              //   ),
              //   onPressed: () {
              //     getSnackBarWidget(
              //       context,
              //       snackBarMsg,
              //       Colors.red,
              //     );
              //     _navigate();
              //   },
              //   child: Text(
              //     'جستجو',
              //     style: TextStyle(
              //       fontFamily: 'irs',
              //       color: Colors.white,
              //       fontSize: 16.sp,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
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
      child: TextField(
        controller: _searchController,
        textInputAction: TextInputAction.search,
        onSubmitted: (value) => _performSearch(value),
        decoration: InputDecoration(
          hintText: 'چه خدمتی نیاز دارید؟',
          hintStyle: TextStyle(fontFamily: 'irs', fontSize: 14.sp),
          border: InputBorder.none,
          prefixIcon: GestureDetector(
            onTap: () {
              getSnackBarWidget(
                        context,
                        snackBarMsg,
                        Colors.red,
                      );
                      _navigate();
            },
            child: Icon(Icons.search, size: 24.sp),
          ),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.close, size: 20.sp),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {});
                  },
                )
              : null,
          contentPadding: EdgeInsets.symmetric(
            vertical: 16.h,
            horizontal: 16.w,
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'irs',
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildRecentSearches() {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: _recentSearches.map((search) {
        return InputChip(
          label: Text(search, style: TextStyle(fontFamily: 'irs')),
          onPressed: () {
            _searchController.text = search;
            _performSearch(search);
          },
          deleteIcon: Icon(Icons.close, size: 16.sp),
          onDeleted: () {
            setState(() {
              _recentSearches.remove(search);
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildPopularServices() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 3,
      ),
      itemCount: _popularServices.length,
      itemBuilder: (context, index) {
        return _buildServiceCard(_popularServices[index]);
      },
    );
  }

  Widget _buildServiceCard(String service) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: getBorderRadiusFunc(8),
      ),
      child: InkWell(
        borderRadius: getBorderRadiusFunc(8),
        onTap: () {
          _searchController.text = service;
          _performSearch(service);
        },
        child: Padding(
          padding: EdgeInsets.all(12.sp),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.sp),
                decoration: BoxDecoration(
                  color: buttonColor.withOpacity(0.1),
                  borderRadius: getBorderRadiusFunc(6),
                ),
                child: Icon(
                  _getServiceIcon(service),
                  size: 20.sp,
                  color: buttonColor,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  service,
                  style: TextStyle(
                    fontFamily: 'irs',
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getServiceIcon(String service) {
    switch (service) {
      case 'رزرو هتل':
        return Icons.hotel;
      case 'بلیط هواپیما':
        return Icons.airplanemode_active;
      case 'تور داخلی':
        return Icons.tour;
      case 'رستوران':
        return Icons.restaurant;
      case 'اجاره ویلا':
        return Icons.villa;
      case 'بلیط قطار':
        return Icons.train;
      default:
        return Icons.search;
    }
  }

  void _performSearch(String query) {
    if (query.trim().isEmpty) return;

    // Add to recent searches if not already there
    if (!_recentSearches.contains(query)) {
      setState(() {
        _recentSearches.insert(0, query);
        if (_recentSearches.length > 5) {
          _recentSearches.removeLast();
        }
      });
    }

    // TODO: Implement actual search functionality
    // Navigator.push to search results screen
    print('Searching for: $query');
  }
}
