import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tripto_flutter/const/shape/border_radius.dart';
import 'package:tripto_flutter/const/shape/media_query.dart';
import 'package:tripto_flutter/const/theme/colors.dart';
import 'package:tripto_flutter/features/new_trip_features/bloc/new_trip_bloc.dart';
import 'package:tripto_flutter/features/new_trip_features/services/new_trip_api_repository.dart';
import 'package:tripto_flutter/features/public_features/functions/number_to_three/number_to_three.dart';
import 'package:tripto_flutter/features/public_features/functions/pref/save_user_id.dart';
import 'package:tripto_flutter/features/public_features/functions/price_generator/price_generator.dart';
import 'package:tripto_flutter/features/public_features/logic/token_checker/token_check_cubit.dart';
import 'package:tripto_flutter/features/public_features/screen/bottom_nav_screen.dart';
import 'package:tripto_flutter/features/public_features/widget/error_screen_widget.dart';
import 'package:tripto_flutter/features/public_features/widget/snack_bar_widget.dart';

import '../../public_features/functions/id_generator/trip_id_generator.dart';
import '../../public_features/functions/pref/save_trip_id.dart';

class NewTripScreen extends StatefulWidget {
  const NewTripScreen({super.key});

  static const String screenId = 'new-trip';

  @override
  _NewTripScreenState createState() => _NewTripScreenState();
}

class _NewTripScreenState extends State<NewTripScreen> {
  String originCity = '';  // مقدار پیش‌فرض برای شهر مبدا
  String destinationCity = '';  // مقدار پیش‌فرض برای شهر مقصد
  List<String> cities = [];
  String selectedTripType = 'یک طرفه';
  int numberOfPassengers = 1;
  bool isDomestic = true;
  bool isLoading = true;
  DateTime selectedDate = DateTime.now();  // مقدار پیش‌فرض برای تاریخ
  int finalPrice = 0;  // مقدار پیش‌فرض برای قیمت
  bool shouldChangeTheValue = false;
  String tripId = 'defaultTripId';  // مقدار پیش‌فرض برای tripId

  @override
  void initState() {
    super.initState();
    fetchCities();
    showTripId();
  }

  // دریافت tripId ذخیره‌شده
  void showTripId() async {
    final savedTripId = await SaveTripId().getTripId();
    setState(() {
      tripId = savedTripId ?? 'defaultTripId';  // اگر مقدار tripId نال باشد، از یک مقدار پیش‌فرض استفاده می‌شود
    });
  }

  // بارگذاری لیست شهرها
  Future<void> fetchCities() async {
    final Dio dio = Dio();
    try {
      final response = await dio.get('https://iranplacesapi.liara.run/api/cities');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        if (data is List) {
          setState(() {
            cities = data.map<String>((city) => city['name'].toString()).toList();
            isLoading = false;
          });
        }
      }
    } catch (e) {
      setState(() => isLoading = false);
      getSnackBarWidget(context, 'خطا در بارگذاری شهر ها', Colors.red);
    }
  }

  // انتخاب تاریخ
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,  // از selectedDate به‌عنوان تاریخ اولیه استفاده می‌کنیم
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: buttonColor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewTripBloc(
        NewTripApiRepository(),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: buttonColor,
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(Icons.arrow_forward, color: Colors.white),
              onPressed: () => Navigator.pushNamed(context, BottomNavBarScreen.screenId),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: BlocListener<NewTripBloc, NewTripState>(
            listener: (context, state) {
              if (state is NewTripCompletedState) {
                print('object');
              }
            },
            child: Column(
              children: [
                _buildFlightTypeToggle(),
                SizedBox(height: 20),
                _buildTripTypeCard(),
                SizedBox(height: 20),
                _buildCityCard(
                  title: 'مبدا',
                  value: originCity,
                  onChanged: (value) => setState(() => originCity = value!),
                ),
                SizedBox(height: 20),
                _buildCityCard(
                  title: 'مقصد',
                  value: destinationCity,
                  onChanged: (value) => setState(() => destinationCity = value!),
                ),
                SizedBox(height: 20),
                _buildDatePickerCard(),
                SizedBox(height: 20),
                _buildPassengersCard(),
                SizedBox(height: 30),
                _displayFinalPrice(),
                SizedBox(height: 30),

                // BlocBuilder section
                BlocBuilder<TokenCheckCubit, TokenCheckState>(
                  builder: (context, state) {
                    if (state is TokenLoggedState) {
                      return _buildSearchButton();
                    } else if (state is TokenNotLoggedState) {
                      return ElevatedButton(
                        onPressed: () {
                          getSnackBarWidget(context, 'ابتدا وارد حساب کاربری شوید', Colors.red);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: getBorderRadiusFunc(12),
                          ),
                          fixedSize: Size(
                            getAllWidth(context),
                            getHeight(context, 0.05),
                          ),
                        ),
                        child: Text(
                          'وارد حساب کاربری شوید',
                          style: TextStyle(
                            fontFamily: 'irs',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // دکمه جستجو یا خرید بلیط
  Widget _buildSearchButton() {
    return SizedBox(
      width: getAllWidth(context),
      child: ElevatedButton(
        onPressed: () {
          if (!shouldChangeTheValue) {
            if (originCity.isEmpty || destinationCity.isEmpty || selectedDate == null) {
              getSnackBarWidget(context, 'لطفاً تمام اطلاعات را وارد کنید', Colors.red);
              return;
            }

            if (originCity == destinationCity) {
              getSnackBarWidget(context, 'مبدا و مقصد نمی توانند یکی باشند !', Colors.red);
              return;
            }

            int price = generateRandomPrice(
              isRoundTrip: selectedTripType == 'رفت و برگشت',
            );

            setState(() {
              finalPrice = price;
              shouldChangeTheValue = true;
            });

            if (tripId.isEmpty) {
              getSnackBarWidget(context, 'خطا در دریافت آیدی', Colors.red);
              return;
            }
          } else {
            BlocProvider.of<NewTripBloc>(context).add(
              CallNewTripEvent(
                tripId: tripId,
                originPlace: originCity,
                destinationPlace: destinationCity,
                tripPrice: finalPrice.toString(),
                isRoundTrip: selectedTripType == 'رفت و برگشت',
              ),
            );
            getSnackBarWidget(context, 'خرید بلیط با موفقیت انجام شد !', Colors.green);

            Navigator.pushNamedAndRemoveUntil(
              context,
              BottomNavBarScreen.screenId,
                  (route) => false,
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        child: Text(
          shouldChangeTheValue ? 'خرید بلیط پرواز' : 'جستجوی پرواز',
          style: TextStyle(
            fontFamily: 'irs',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // انتخاب نوع پرواز (داخلی یا خارجی)
  Widget _buildFlightTypeToggle() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: _buildToggleButton(
                text: 'پرواز داخلی',
                isActive: isDomestic,
                onPressed: () => setState(() => isDomestic = true),
              ),
            ),
            Expanded(
              child: _buildToggleButton(
                text: 'پرواز خارجی',
                isActive: !isDomestic,
                onPressed: () {
                  setState(() => isDomestic = false);
                  getSnackBarWidget(context, 'فعلاً فقط پرواز داخلی ممکن است!',
                      Colors.orange);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ساخت دکمه برای انتخاب پرواز
  Widget _buildToggleButton(
      {required String text,
        required bool isActive,
        required VoidCallback onPressed}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: isActive ? buttonColor : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: isActive ? buttonColor : Colors.grey[300]!),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onPressed,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  fontFamily: 'irs',
                  color: isActive ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // کارت برای انتخاب نوع سفر (یک طرفه یا رفت و برگشت)
  Widget _buildTripTypeCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: DropdownButton<String>(
          value: selectedTripType,
          isExpanded: true,
          underline: SizedBox(),
          icon: Icon(Icons.arrow_drop_down),
          onChanged: (value) => setState(() => selectedTripType = value!),
          items: ['یک طرفه', 'رفت و برگشت'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: TextStyle(fontFamily: 'irs')),
            );
          }).toList(),
        ),
      ),
    );
  }

  // کارت برای انتخاب شهر
  Widget _buildCityCard({
    required String title,
    required String value,
    required ValueChanged<String?> onChanged,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(color: Colors.grey[600], fontSize: 12)),
            isLoading
                ? Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Center(
                child: Text(
                  'درحال بارگذاری شهر ها ...',
                  style: TextStyle(
                    fontFamily: 'irs',
                  ),
                ),
              ),
            )
                : DropdownButton<String>(
              value: value.isEmpty ? null : value,  // اینجا از مقدار غیر نال استفاده می‌کنیم
              isExpanded: true,
              underline: SizedBox(),
              icon: Icon(
                Icons.location_on,
                color: buttonColor,
              ),
              hint: Text('انتخاب کنید',
                  style: TextStyle(fontFamily: 'irs')),
              onChanged: onChanged,
              items: cities.map((String city) {
                return DropdownMenuItem<String>(
                  value: city,
                  child: Text(city, style: TextStyle(fontFamily: 'irs')),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  // انتخاب تاریخ پرواز
  Widget _buildDatePickerCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _selectDate(context),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(Icons.calendar_today, color: buttonColor),
              SizedBox(width: 12),
              Text(
                selectedDate == null
                    ? 'تاریخ پرواز'
                    : '${selectedDate!.year}/${selectedDate!.month}/${selectedDate!.day}',
                style: TextStyle(fontFamily: 'irs'),
              ),
              Spacer(),
              Text('انتخاب تاریخ', style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }

  // کارت تعداد مسافران
  Widget _buildPassengersCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('تعداد مسافران',
                style: TextStyle(color: Colors.grey[600], fontSize: 12)),
            Row(
              children: [
                Icon(Icons.people, color: buttonColor),
                SizedBox(width: 12),
                Expanded(
                  child: Slider(
                    value: numberOfPassengers.toDouble(),
                    min: 1,
                    max: 10,
                    divisions: 9,
                    activeColor: buttonColor,
                    label: numberOfPassengers.toString(),
                    onChanged: (value) =>
                        setState(() => numberOfPassengers = value.toInt()),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: buttonColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    numberOfPassengers.toString(),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // نمایش قیمت قابل پرداخت
  Widget _displayFinalPrice() {
    return Row(
      spacing: 5.sp,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'قابل پرداخت :',
          style: TextStyle(
            fontFamily: 'irs',
            color: Colors.green,
            fontSize: 15.sp,
          ),
        ),
        Text(
            style: TextStyle(
              fontFamily: 'irs',
              color: Colors.green,
              fontSize: 15.sp,
            ),
            finalPrice != null
                ? getFormatPrice(
              finalPrice.toString(),
            ) +
                'تومان'
                : ''),
      ],
    );
  }
}
