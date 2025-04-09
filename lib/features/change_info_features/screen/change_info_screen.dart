import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tripto_flutter/const/theme/colors.dart';
import 'package:tripto_flutter/features/public_features/widget/snack_bar_widget.dart';

import '../../public_features/functions/pref/save_phone_number.dart';

class ChangeInfoScreen extends StatefulWidget {
  const ChangeInfoScreen({super.key});

  static const String screenId = 'change_info';

  @override
  State<ChangeInfoScreen> createState() => _ChangeInfoScreenState();
}

class _ChangeInfoScreenState extends State<ChangeInfoScreen> {
  String currentPhoneNumber = '';
  final TextEditingController _phoneController = TextEditingController();

  void _loadNumber() async {
    String? getNumber = await getPhoneNumber();
    setState(() {
      currentPhoneNumber = getNumber ?? 'No number';
      _phoneController.text = currentPhoneNumber;
    });
  }

  void _saveNewPhoneNum() async {
    String newPhoneNum = _phoneController.text;
    if (newPhoneNum.isNotEmpty) {
      await savePhoneNumber(newPhoneNum);
      setState(() {
        currentPhoneNumber = newPhoneNum;
      });
      getSnackBarWidget(context, 'شماره با موفقیت تغییر کرد', Colors.green);
    }
  }

  void _showEditPhoneDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'ویرایش شماره تلفن',
            style: TextStyle(fontFamily: 'irs', fontSize: 14.sp),
          ),
          content: TextField(
            controller: _phoneController,
            decoration: InputDecoration(
              labelText: 'شماره تلفن جدید',
              labelStyle: TextStyle(
                fontFamily: 'irs',
                fontSize: 14.sp,
              ),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.phone,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'لغو',
                style: TextStyle(
                  fontFamily: 'irs',
                  color: Colors.red,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                _saveNewPhoneNum();
                Navigator.pop(context);
              },
              child: const Text(
                'ذخیره',
                style: TextStyle(
                  fontFamily: 'irs',
                  color: Colors.green,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _loadNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: buttonColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // نمایش شماره تلفن فعلی
            Row(
              children: [
                const Icon(Icons.phone, color: Colors.green),
                const SizedBox(width: 10),
                Text(
                  'شماره موبایل:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'irs',
                  ),
                ),
                Spacer(),
                Text(
                  currentPhoneNumber,
                  style: TextStyle(fontSize: 16),
                ),
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    _showEditPhoneDialog();
                  },
                ),
              ],
            ),
            const Divider(),
            ListTile(
              trailing: Icon(Icons.add),
              leading: const Icon(Icons.email),
              title: Text(
                'افزودن آدرس ایمیل',
                style: TextStyle(
                  fontFamily: 'irs',
                ),
              ),
              onTap: () {},
            ),
            const Divider(),

            // ویرایش کلمه عبور
            ListTile(
              trailing: Icon(Icons.edit),
              leading: const Icon(Icons.lock),
              title: const Text(
                'ویرایش کلمه عبور',
                style: TextStyle(
                  fontFamily: 'irs',
                ),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
