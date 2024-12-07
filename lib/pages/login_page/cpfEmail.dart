import 'package:flutter/material.dart';

bool checaResp(String value) {
  final cpfRegex = RegExp(r'^\d{3}\.\d{3}\.\d{3}-\d{2}$|^\d{11}$');
  
  if (value.contains('@')||cpfRegex.hasMatch(value)) {
    return true;
  }else {
    return false;
  }
}
