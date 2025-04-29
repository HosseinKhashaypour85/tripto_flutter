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

  Future<void> _loadCurrentBalance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      currentBalance = prefs.getInt('account_balance') ?? 0;
    });
  }

  Future<void> _addBalance(int amount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int newBalance = currentBalance + amount;
    await prefs.setInt('account_balance', newBalance);
    setState(() {
      currentBalance = newBalance;
    });
    getSnackBarWidget(context, 'مبلغ ${getFormatPrice(amount.toString())} تومان به حساب شما اضافه شد', Colors.green);
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
        title: Text(
          'افزایش موجودی',
          style: TextStyle(
            fontFamily: 'irs',
            fontSize: 18.sp,
          ),
        ),
        centerTitle: true,
        backgroundColor: buttonColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16.sp),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Balance Card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.sp),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'موجودی فعلی شما',
                      style: TextStyle(
                        fontFamily: 'irs',
                        fontSize: 14.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    SizedBox(height: 8.sp),
                    Text(
                      '${getFormatPrice(currentBalance.toString())} تومان',
                      style: TextStyle(
                        fontFamily: 'irs',
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 32.sp),

            // Suggested Amounts
            Text(
              'مبالغ پیشنهادی',
              style: TextStyle(
                fontFamily: 'irs',
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.sp),
            Wrap(
              spacing: 12.sp,
              runSpacing: 12.sp,
              children: suggestedAmounts.map((amount) {
                return ChoiceChip(
                  label: Text(
                    '${getFormatPrice(amount.toString())} تومان',
                    style: TextStyle(
                      fontFamily: 'irs',
                      color: selectedAmount == amount ? Colors.white : Theme.of(context).primaryColor,
                    ),
                  ),
                  selected: selectedAmount == amount,
                  onSelected: (isSelected) => _selectSuggestedAmount(amount),
                  selectedColor: Theme.of(context).primaryColor,
                  backgroundColor: Colors.grey.shade100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.sp),
                    side: BorderSide(
                      color: selectedAmount == amount
                          ? Colors.transparent
                          : Colors.grey.shade300,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.sp,
                    vertical: 12.sp,
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 32.sp),

            // Custom Amount Input
            Text(
              'مبلغ دلخواه',
              style: TextStyle(
                fontFamily: 'irs',
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.sp),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: 'مبلغ را به تومان وارد کنید',
                labelStyle: TextStyle(
                  fontFamily: 'irs',
                  color: Colors.grey.shade600,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.sp),
                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.sp),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 2,
                  ),
                ),
                contentPadding: EdgeInsets.all(16.sp),
                prefixIcon: Icon(
                  Icons.attach_money_rounded,
                  color: Colors.grey.shade500,
                ),
                suffixText: 'تومان',
                suffixStyle: TextStyle(
                  fontFamily: 'irs',
                  color: Colors.grey.shade600,
                ),
              ),
              keyboardType: TextInputType.number,
              style: TextStyle(
                fontFamily: 'irs',
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 40.sp),

            // Add Balance Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  int amount = int.tryParse(_amountController.text) ?? 0;
                  if (amount > 0) {
                    _addBalance(amount);
                    Navigator.pop(context);
                  } else {
                    getSnackBarWidget(
                        context,
                        'لطفا مبلغ معتبری وارد کنید',
                        Colors.red
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.sp),
                  backgroundColor: buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.sp),
                  ),
                  elevation: 0,
                  shadowColor: Colors.transparent,
                ),
                child: Text(
                  'افزایش موجودی',
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
    );
  }
}