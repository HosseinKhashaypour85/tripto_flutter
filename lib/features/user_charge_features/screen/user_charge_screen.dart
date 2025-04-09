import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tripto_flutter/const/shape/media_query.dart';
import 'package:tripto_flutter/features/public_features/functions/number_to_three/number_to_three.dart';
import 'package:tripto_flutter/features/public_features/widget/snack_bar_widget.dart';
import '../../../const/theme/colors.dart';

class AddBalanceScreen extends StatefulWidget {
  const AddBalanceScreen({super.key});

  static const String screenId = 'user_charge';

  @override
  _AddBalanceScreenState createState() => _AddBalanceScreenState();
}

class _AddBalanceScreenState extends State<AddBalanceScreen> {
  final TextEditingController _amountController = TextEditingController();
  int currentBalance = 0;
  int selectedAmount = 0;

  List<int> suggestedAmounts = [10000, 50000, 100000];

  // بارگذاری موجودی از SharedPreferences
  Future<void> _loadCurrentBalance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      currentBalance = prefs.getInt('account_balance') ?? 0;
    });
  }

  // ذخیره موجودی جدید در SharedPreferences
  Future<void> _addBalance(int amount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int newBalance = currentBalance + amount;
    await prefs.setInt('account_balance', newBalance);
    setState(() {
      currentBalance = newBalance;
    });
    getSnackBarWidget(context, 'مبلغ ${amount}  به حساب شما اضافه شد', Colors.green);
  }

  void _selectSuggestedAmount(int amount) {
    setState(() {
      selectedAmount = amount;
      _amountController.text = selectedAmount.toString();
    });
  }

  @override
  void initState() {
    super.initState();
    _loadCurrentBalance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: buttonColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'موجودی فعلی: $currentBalance تومان',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'irs',
              ),
            ),
            SizedBox(height: 20.sp),
            // نمایش FilterChip برای مبالغ پیشنهادی
            Wrap(
              spacing: 10.sp,
              runSpacing: 10.sp,
              children: suggestedAmounts.map((amount) {
                return FilterChip(
                  label: Text(
                    style: TextStyle(
                      fontFamily: 'irs',
                    ),
                    '${getFormatPrice(
                      amount.toString(),
                    )}تومان',
                  ),
                  selected: selectedAmount == amount,
                  onSelected: (isSelected) {
                    _selectSuggestedAmount(amount);
                    setState(() {
                      isSelected = !isSelected;
                    });
                  },
                  selectedColor: buttonColor,
                  backgroundColor: Colors.grey[300],
                  labelStyle: TextStyle(
                    color:
                        selectedAmount == amount ? Colors.white : Colors.black,
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20.sp),
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: 'مقدار افزایش موجودی',
                labelStyle: TextStyle(fontFamily: 'irs'),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20.sp),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  int amount = int.tryParse(_amountController.text) ?? 0;
                  if (amount > 0) {
                    _addBalance(amount); // افزایش موجودی
                  } else {
                    getSnackBarWidget(
                        context, 'لطفا مبلغ بیشتری وارد کنید', Colors.red);
                  }
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(10.sp),
                  fixedSize: Size(
                    getAllWidth(context),
                    getHeight(context, 0.05.sp),
                  ),
                  backgroundColor: linkColor,
                ),
                child: Text(
                  'افزایش موجودی',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: 'irs',
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
