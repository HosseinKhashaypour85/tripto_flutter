import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tripto_flutter/const/theme/colors.dart';
import 'package:tripto_flutter/features/auth_features/logic/auth_bloc.dart';
import 'package:tripto_flutter/features/auth_features/screen/activation_code_screen.dart';
import 'package:tripto_flutter/features/auth_features/services/auth_api_repository.dart';
import 'package:tripto_flutter/features/change_info_features/logic/change_bloc.dart';
import 'package:tripto_flutter/features/change_info_features/services/change_api_repository.dart';
import 'package:tripto_flutter/features/home_features/screen/home_screen.dart';
import 'package:tripto_flutter/features/intro_features/splash_screen.dart';
import 'package:tripto_flutter/features/new_trip_features/bloc/new_trip_bloc.dart';
import 'package:tripto_flutter/features/new_trip_features/services/new_trip_api_repository.dart';
import 'package:tripto_flutter/features/notifications_features/logic/notifications_bloc.dart';
import 'package:tripto_flutter/features/notifications_features/services/notifications_api_repository.dart';
import 'package:tripto_flutter/features/public_features/logic/bottom_nav_cubit.dart';
import 'package:tripto_flutter/features/public_features/logic/token_checker/token_check_cubit.dart';
import 'package:tripto_flutter/features/public_features/screen/bottom_nav_screen.dart';
import 'package:flutter/services.dart';
import 'package:tripto_flutter/features/trips_history_features/logic/trips_history_bloc.dart';
import 'package:tripto_flutter/features/trips_history_features/services/trips_api_repository.dart';

import 'features/auth_features/screen/auth_screen.dart';
import 'features/auth_features/screen/sign_up_screen.dart';
import 'features/biometric_services_features/biometric_screen.dart';
import 'features/change_info_features/screen/change_info_screen.dart';
import 'features/home_features/logic/cubit/carousel_cubit.dart';
import 'features/new_trip_features/screen/new_trip_screen.dart';
import 'features/search_features/screen/search_screen.dart';
import 'features/trip_info_features/screen/trip_info_screen.dart';
import 'features/trips_history_features/screen/trips_history_screen.dart';
import 'features/user_charge_features/screen/user_charge_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // init notifications
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: buttonColor,
    statusBarIconBrightness: Brightness.dark,
  ));
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => BottomNavCubit(),
          ),
          BlocProvider(
            create: (context) => CarouselCubit(),
          ),
          BlocProvider(
            create: (context) => TokenCheckCubit(),
          ),
          BlocProvider(
            create: (context) => AuthBloc(
              AuthApiRepository(),
            ),
          ),
          BlocProvider(
            create: (context) => ChangeBloc(
              ChangeApiRepository(),
            ),
          ),
          BlocProvider(
            create: (context) => NotificationsBloc(
              NotificationsApiRepository(),
            ),
          ),
          BlocProvider(
            create: (context) => TripsHistoryBloc(
              TripsApiRepository(),
            ),
          ),
          BlocProvider(
            create: (context) => NewTripBloc(
              NewTripApiRepository(),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('fa'),
          ],
          initialRoute: SplashScreen.screenId,
          routes: {
            BottomNavBarScreen.screenId: (context) => BottomNavBarScreen(),
            SplashScreen.screenId: (context) => SplashScreen(),
            HomeScreen.screenId: (context) => HomeScreen(),
            AuthScreen.screenId: (context) => AuthScreen(),
            SignUpScreen.screenId: (context) => SignUpScreen(),
            ChangeInfoScreen.screenId: (context) => ChangeInfoScreen(),
            AddBalanceScreen.screenId: (context) => AddBalanceScreen(),
            TripsHistoryScreen.screenId: (context) => TripsHistoryScreen(),
            NewTripScreen.screenId: (context) => NewTripScreen(),
            TripInfoScreen.screenId: (context) => TripInfoScreen(),
            ServiceSearchScreen.screenId: (context) => ServiceSearchScreen(),
            BiometricScreen.screenId: (context) => BiometricScreen(),
          },
        ),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
