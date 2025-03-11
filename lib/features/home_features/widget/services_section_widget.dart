import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tripto_flutter/features/home_features/widget/services_icon_widget.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 30.sp,
      children: [
        ServicesIconWidget(
          icon: Icons.credit_card,
          text: 'سفر سازمانی',
        ),
        ServicesIconWidget(
          icon: Icons.badge,
          text: 'ویزای سفر',
        ),
        ServicesIconWidget(
          icon: Icons.payments,
          text: 'سفر اقساطی',
        ),
        ServicesIconWidget(
          icon: Icons.directions_bus,
          text: 'تور گردشگری',
        ),
      ],
    );
  }
}
