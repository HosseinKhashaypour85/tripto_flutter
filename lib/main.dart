import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tripto_flutter/const/theme/colors.dart';
import 'package:tripto_flutter/features/home_features/screen/home_screen.dart';
import 'package:tripto_flutter/features/intro_features/splash_screen.dart';
import 'package:tripto_flutter/features/public_features/logic/bottom_nav_cubit.dart';
import 'package:tripto_flutter/features/public_features/screen/bottom_nav_screen.dart';
import 'package:flutter/services.dart';

import 'features/home_features/logic/cubit/carousel_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: buttonColor,
    statusBarIconBrightness: Brightness.dark,
  ));
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
          },
        ),
      ),
    );
  }
}
