// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:gym_management/pages/common/constants/ColorsConst.dart';

class DashboardImageBtn extends StatelessWidget {
  
  final Text btnText;
  final VoidCallback onPressed;

  const DashboardImageBtn({
    super.key,
    required this.btnText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 75),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(150, 60),
          backgroundColor: ColorsConst.dashboardButtonSlide,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: onPressed,
        child: btnText,
      ),
    );
  }
}
