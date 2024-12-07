// ignore_for_file: file_names

import 'package:flutter/material.dart';

class NavigationItem {
  final String text;
  final IconData icon;
  final void Function(BuildContext) onPressed;
  
  NavigationItem({
    required this.text,
    required this.icon,
    required this.onPressed,
  });
}
