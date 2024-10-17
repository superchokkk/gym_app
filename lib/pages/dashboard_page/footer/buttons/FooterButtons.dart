// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym_management/pages/common/constants/ColorsConst.dart';

class FooterButton extends StatelessWidget {
  
  final BorderRadius borderRadius;
  final double width;
  final double height;
  final VoidCallback onPressed;
  final IconData icon;

  const FooterButton({
    super.key,
    required this.borderRadius,
    required this.width,
    required this.height,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: Size(width - 1, 65),
          backgroundColor: ColorsConst.dashboardButtonSlide,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius,
          ),
        ),
        onPressed: onPressed,
        child: FaIcon(
          icon,
          color: Colors.white,
          size: 20,
        )
      );
  }
}
