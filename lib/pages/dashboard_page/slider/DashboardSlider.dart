// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:gym_management/pages/common/constants/TextStylesConst.dart';
import 'package:gym_management/pages/common/constants/ButtonConfig.dart';
import 'package:gym_management/pages/dashboard_page/slider/btn/DashboardImageBtn.dart';
import 'package:gym_management/pages/dashboard_page/slider/dots/DotsSliderController.dart';
import 'package:gym_management/pages/dashboard_page/slider/img_slide/ImageSlide.dart';

class DashboardSlider extends StatefulWidget {
  const DashboardSlider({super.key});

  @override
  State<DashboardSlider> createState() => _DashboardSliderState();
}

class _DashboardSliderState extends State<DashboardSlider> {

  ButtonConfigs navBtn = ButtonConfigs();

  final List<String> imagePaths = [
    'assets/img/bfimage.png',
    'assets/img/women-tredmill.png',
  ];
  int _currentIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);
  late List<Widget> _slides;

  @override
  void initState() {
    super.initState();
    _slides = List.generate(
        imagePaths.length, (index) => ImageSlide(imagePath: imagePaths[index]));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Column(
          children: [
            Container(
              width: 370,
              height: 230,
              decoration: const BoxDecoration(
                color: Color(0xFFFFFFFF),
              ),
              child: PageView.builder(
                controller: _pageController,
                itemCount: imagePaths.length,
                itemBuilder: (context, index) {
                  return Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      _slides[index],
                        Align(
                          alignment: Alignment.topCenter,
                          child: DashboardImageBtn(
                            btnText: Text(
                              navBtn.dashboardSliderButtonsConfig[index]['text'],
                              style: TextStylesConst.dashboardSliderBtnTextStyle,
                            ),
                            onPressed: navBtn.dashboardSliderButtonsConfig[index]['onPressed'],
                          ),
                        ),
                    ],
                  );
                },
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 15,
          child: DotsSliderController(
            imagePaths: imagePaths,
            currentIndex: _currentIndex,
            pageController: _pageController,
          ),
        ),
      ],
    );
  }
}
