// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym_management/pages/common/constants/ColorsConst.dart';
import 'package:gym_management/pages/common/widgets/CircleButton.dart';

class DashboardNavigationItems extends StatelessWidget {
  final Text itemText;
  final VoidCallback onPressed;
  final FaIcon icon;

  const DashboardNavigationItems({
    super.key,
    required this.itemText,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              child: CircleButton(
                icon: icon, 
                onPressed: onPressed,
                btnColor: ColorsConst.dashboardButton,
                size: const Size(90, 90),
              )
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: itemText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
