// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:gym_management/pages/common/constants/ColorsConst.dart';
import 'package:gym_management/pages/dashboard_page/footer/buttons/FooterButtons.dart';

class DashboardFooter extends StatelessWidget {
  final double width = 200;
  final double height = 65;

  const DashboardFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
              decoration: const BoxDecoration(
                border:
                    Border(right: BorderSide(color: Colors.white, width: 1)),
              ),
              child: FooterButton(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                width: width / 2,
                height: height,
                onPressed: () {
                  print("Btn user pressed!");
                },
                icon: FontAwesomeIcons.user,
              )),
          Container(
              decoration: const BoxDecoration(
                border: Border(left: BorderSide(color: Colors.white, width: 1)),
              ),
              child: FooterButton(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                width: width / 2,
                height: height,
                onPressed: () {
                  print("Btn user pressed!");
                },
                icon: FontAwesomeIcons.plus,
              )),
        ],
      ),
    );
  }
}
