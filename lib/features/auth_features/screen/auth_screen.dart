import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tripto_flutter/const/shape/border_radius.dart';
import 'package:tripto_flutter/const/shape/media_query.dart';
import 'package:tripto_flutter/const/theme/colors.dart';
import 'package:tripto_flutter/features/auth_features/logic/auth_bloc.dart';
import 'package:tripto_flutter/features/auth_features/screen/sign_up_screen.dart';
import 'package:tripto_flutter/features/auth_features/services/auth_api_repository.dart';
import 'package:tripto_flutter/features/auth_features/widget/passwordfield_widget.dart';
import 'package:tripto_flutter/features/auth_features/widget/textformfield_widget.dart';

import '../../public_features/functions/pref/save_phone_number.dart';
import '../../public_features/functions/secure_storage/secure_storage.dart';
import '../../public_features/screen/bottom_nav_screen.dart';
import '../../public_features/widget/snack_bar_widget.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  static const String screenId = 'auth';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isShow = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(AuthApiRepository()),
      child: BlocConsumer<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is SignInAuthLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          }
          return Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  // Logo
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "TripTo",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'irs',
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          "TT",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber,
                            fontFamily: 'irs',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "ورود یا ثبت نام",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'irs',
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Phone Input
                  TextFormFieldMobileWidget(
                    labelText: 'شماره موبایل',
                    icon: const Icon(Icons.send_to_mobile),
                    textInputAction: TextInputAction.done,
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    controller: _phoneController,
                    suffixIcon: null,
                  ),
                  SizedBox(height: 10.sp),
                  PasswordFieldWidget(
                    labelText: 'رمز عبور',
                    icon: const Icon(Icons.password),
                    textInputAction: TextInputAction.done,
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    controller: _passwordController,
                    suffixIcon: null,
                    prefixIcon: null,
                  ),
                  SizedBox(height: 10.sp),
                  Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: boxColors,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "استفاده از تریپتو به معنی پذیرش قوانین است.",
                        style: TextStyle(
                          fontSize: 14,
                          color: boxColors,
                          fontFamily: 'irs',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        SignUpScreen.screenId,
                      );
                    },
                    child: const Text(
                      "حساب کاربری ندارید؟ ثبت نام کنید",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'irs',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Submit Button
                  Spacer(),
                  Container(
                    width: getAllWidth(context),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary3Color,
                        shape: RoundedRectangleBorder(
                          borderRadius: getBorderRadiusFunc(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        BlocProvider.of<AuthBloc>(context).add(
                          CallSignInEvent(
                            _phoneController.text,
                            _passwordController.text,
                          ),
                        );
                      },
                      child: const Text(
                        "تأیید و ورود",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'irs',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state is SignInAuthErrorState) {
            getSnackBarWidget(
                context, state.errorMessageClass.errorMsg!, Colors.red);
          }
          if (state is SignInAuthCompletedState) {
            SecureStorage().saveUserToken(state.token);
            savePhoneNumber(_phoneController.text);
            Navigator.pushNamedAndRemoveUntil(
              context,
              BottomNavBarScreen.screenId,
              (route) => false,
            );
          }
        },
      ),
    );
  }
}
