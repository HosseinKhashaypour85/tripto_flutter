import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tripto_flutter/const/theme/colors.dart';
import 'package:tripto_flutter/features/notifications_features/logic/notifications_bloc.dart';
import 'package:tripto_flutter/features/public_features/logic/token_checker/token_check_cubit.dart';

class NotificationsTypeChipWidget extends StatefulWidget {
  const NotificationsTypeChipWidget({super.key});

  @override
  State<NotificationsTypeChipWidget> createState() =>
      _NotificationsTypeChipState();
}

class _NotificationsTypeChipState extends State<NotificationsTypeChipWidget> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsBloc, NotificationsState>(
      builder: (context, state) {
        return BlocBuilder<TokenCheckCubit , TokenCheckState>(
          builder: (context, state) {
            if(state is TokenLoggedState){
              return Wrap(
                spacing: 8,
                children: [
                  _buildChip("همه", Icons.notifications, 0),
                  _buildChip("تغییرات پرواز", Icons.flight_takeoff, 1),
                  _buildChip("اطلاع رسانی", Icons.notifications_active, 2),
                  _buildChip("شخصی", Icons.person, 3),
                ],
              );
            }
            if(state is TokenNotLoggedState){
              return SizedBox.shrink();
            }
            return SizedBox.shrink();
          },
        );
      },
    );
  }

  Widget _buildChip(String label, IconData icon, int index) {
    return Padding(
      padding: EdgeInsets.only(right: 8.0),
      child: FilterChip(
        backgroundColor:
        selectedIndex == index ? buttonColor : Colors.white,
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 18.sp,
              color: selectedIndex == index ? Colors.white : Colors.black,
            ),
            SizedBox(width: 8.sp),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'irs',
                color: selectedIndex == index ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
        onSelected: (bool selected) {
          setState(() {
            selectedIndex = selected ? index : -1;
          });
        },
      ),
    );
  }
}
