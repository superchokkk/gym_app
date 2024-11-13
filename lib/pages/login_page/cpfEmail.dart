import 'package:flutter/material.dart';

int checaResp(String value) {
  final cpfRegex = RegExp(r'^\d{3}\.\d{3}\.\d{3}-\d{2}$|^\d{11}$');
  
  if (value.contains('@')) {
    print("1");
    return 1;
  } else if (cpfRegex.hasMatch(value)) {
    print("2");
    return 2;
  } else {
    print("0");
    return 0;
  }
}
