import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripto_flutter/features/auth_features/screen/auth_screen.dart';
import 'package:tripto_flutter/features/profile_features/screen/profile_screen.dart';
import 'package:tripto_flutter/features/public_features/logic/token_checker/token_check_cubit.dart';

class CheckProfile extends StatefulWidget {
  const CheckProfile({super.key});

  static const String screenId = 'check_profile';

  @override
  State<CheckProfile> createState() => _CheckProfileState();
}

class _CheckProfileState extends State<CheckProfile> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TokenCheckCubit , TokenCheckState>(
      builder: (context, state) {
        if(state is TokenLoggedState){
          return ProfileScreen();
        } else{
          return AuthScreen();
        }
      },
    );
  }
}
