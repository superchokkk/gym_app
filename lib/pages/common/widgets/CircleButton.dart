import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CircleButton extends StatelessWidget {
  final FaIcon icon;
  final VoidCallback onPressed;
  final Color btnColor;
  final Size size;

  const CircleButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.btnColor,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: size,
        backgroundColor: btnColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      onPressed: onPressed,
      child: icon,
    );
  }
}
