// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ImageSlide extends StatelessWidget {
  final String? imagePath;
  const ImageSlide({super.key, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath!,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    );
  }
}
