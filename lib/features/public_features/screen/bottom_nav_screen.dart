import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripto_flutter/features/auth_features/screen/auth_screen.dart';
import 'package:tripto_flutter/features/home_features/screen/home_screen.dart';

import '../../../const/theme/colors.dart';
import '../logic/bottom_nav_cubit.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  static const String screenId = 'bottomNav';

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  List<Widget> screenList = [
    HomeScreen(),
    Container(),
    Container(),
    AuthScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit , int>(
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: linkColor,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            unselectedItemColor: Colors.black,
            selectedLabelStyle: const TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
              fontFamily: 'irs',
            ),
            unselectedLabelStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: 'irs',
            ),
            items: [
              BottomNavigationBarItem(
                label: 'خانه',
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                label: 'سفر های من',
                icon: Icon(Icons.work_outline),
                activeIcon: Icon(Icons.work),
              ),
              BottomNavigationBarItem(
                label: 'اعلان ها',
                icon: Icon(Icons.notifications_outlined),
                activeIcon: Icon(Icons.notifications),
              ),
              BottomNavigationBarItem(
                label: 'حساب کاربری',
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person),
              ),
            ],
            currentIndex: BlocProvider.of<BottomNavCubit>(context).currentIndex ,
            onTap: (value) {
              BlocProvider.of<BottomNavCubit>(context).changeIndex(value);
            },
          ),
          body: screenList.elementAt(BlocProvider.of<BottomNavCubit>(context).currentIndex),
        );
      },
    );
  }
}