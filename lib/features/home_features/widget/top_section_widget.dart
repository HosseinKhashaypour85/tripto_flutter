import 'package:flutter/material.dart';

import '../../../const/shape/border_radius.dart';
import '../../../const/theme/colors.dart';
import '../../public_features/widget/search_bar_widget.dart';

class TopSectionWidget extends StatelessWidget {
  const TopSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                color: primary2Color,
                borderRadius: getBorderRadiusFunc(5),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.explore,
                  size: 28,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ),
            Expanded(
              child: SearchBarWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
