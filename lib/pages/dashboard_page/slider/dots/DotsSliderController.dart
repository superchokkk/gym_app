// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:gym_management/pages/common/constants/ColorsConst.dart';

class DotsSliderController extends StatefulWidget {
  final List<String> imagePaths;
  final int currentIndex;
  final PageController pageController;

  const DotsSliderController({
    super.key,
    required this.imagePaths,
    required this.currentIndex,
    required this.pageController,
  });

  @override
  State<DotsSliderController> createState() =>
      _DotsSliderControllerState();
}

class _DotsSliderControllerState extends State<DotsSliderController> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        widget.imagePaths.length,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: InkWell(
            onTap: () {
              setState(() {
                widget.pageController.animateToPage(index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn);
              });
            },
            child: CircleAvatar(
              radius: widget.currentIndex == index ? 6 : 4,
              backgroundColor: widget.currentIndex == index
                  ? ColorsConst.dashboardButtonSlide
                  : Colors.grey[400],
            ),
          ),
        ),
      ),
    );
  }
}
