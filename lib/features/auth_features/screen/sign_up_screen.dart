import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tripto_flutter/const/shape/media_query.dart';
import 'package:tripto_flutter/const/theme/colors.dart';
import 'package:tripto_flutter/features/auth_features/logic/auth_bloc.dart';
import 'package:tripto_flutter/features/auth_features/screen/activation_code_screen.dart';
import 'package:tripto_flutter/features/auth_features/services/auth_api_repository.dart';
import 'package:tripto_flutter/features/auth_features/widget/passwordfield_widget.dart';
import 'package:tripto_flutter/features/public_features/functions/pref/save_phone_number.dart';
import 'package:tripto_flutter/features/public_features/functions/secure_storage/secure_storage.dart';
import 'package:tripto_flutter/features/public_features/widget/snack_bar_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String screenId = 'sign_up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(AuthApiRepository()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: buttonColor,
          elevation: 0,
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(24.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTextField(
                          'نام و نام خانوادگی', _usernameController),
                      _buildTextField(
                          'شماره تلفن', _phoneController, TextInputType.phone),
                      PasswordFieldWidget(
                        labelText: 'رمز عبور',
                        icon: Icon(Icons.password),
                        textInputAction: TextInputAction.done,
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        controller: _passwordController,
                        suffixIcon: null,
                        prefixIcon: null,
                      ),
                      SizedBox(
                        height: 15.sp,
                      ),
                      PasswordFieldWidget(
                        labelText: 'تکرار رمز عبور',
                        icon: Icon(Icons.password),
                        textInputAction: TextInputAction.done,
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        controller: _confirmPasswordController,
                        suffixIcon: null,
                        prefixIcon: null,
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ),
            _buildButtons(context),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      [TextInputType keyboardType = TextInputType.text,
      bool obscureText = false]) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        style: TextStyle(fontFamily: 'irs', fontSize: 13.sp),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: primary2Color, fontFamily: 'irs'),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Colors.grey[200],
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.blue, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'لطفاً $label خود را وارد کنید';
          }

          if (controller == _phoneController) {
            if (value.length != 11) {
              return 'شماره موبایل باید دقیقاً 11 رقم باشد.';
            }
            if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
              return 'شماره موبایل باید فقط شامل اعداد باشد.';
            }
          }

          if (controller == _passwordController && value.length < 8) {
            return 'رمز عبور باید حداقل 8 کاراکتر باشد.';
          }

          if (controller == _confirmPasswordController &&
              value != _passwordController.text) {
            return 'رمز عبور همخوانی ندارد.';
          }

          return null;
        },
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is SignUpAuthCompletedState) {
          SecureStorage().saveUserToken(state.token);
          getSnackBarWidget(context, 'شماره موبایل تایید شد!', Colors.green);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ActivationCodeScreen(
                phoneNumber: _phoneController.text,
              ),
            ),
          );
          savePhoneNumber(_phoneController.text);
        } else if (state is SignInAuthErrorState) {
          getSnackBarWidget(
              context, state.errorMessageClass.errorMsg!, Colors.red);
        }
      },
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              if (state is SignInAuthLoadingState)
                const CircularProgressIndicator(color: buttonColor),
              SizedBox(height: 10.h),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(
                    getAllWidth(context),
                    getHeight(context, 0.07),
                  ),
                  backgroundColor: primary3Color,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    BlocProvider.of<AuthBloc>(context).add(
                      CallSignUpEvent(
                        password: _passwordController.text,
                        confirmPassword: _confirmPasswordController.text,
                        phoneNumber: _phoneController.text,
                        userName: _usernameController.text,
                      ),
                    );
                  }
                },
                child: Text(
                  'ثبت نام',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontFamily: 'irs',
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(
                    getAllWidth(context),
                    getHeight(context, 0.05.sp),
                  ),
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'لغو ثبت نام',
                  style: TextStyle(
                      color: Colors.white, fontSize: 16.sp, fontFamily: 'irs'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
