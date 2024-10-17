// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym_management/pages/common/constants/ColorsConst.dart';

class DashboardFooter extends StatelessWidget {
  const DashboardFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 65,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              border: Border(right: BorderSide(color: Colors.white, width: 1)),
            ),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(99, 65),
                  backgroundColor: ColorsConst.dashboardButtonSlide,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                ),
                onPressed: () {
                  print("Btn user pressed!");
                },
                child: const FaIcon(
                  FontAwesomeIcons.user,
                  color: Colors.white,
                  size: 20,
                )),
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(left: BorderSide(color: Colors.white, width: 1)),
            ),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(99, 65),
                  backgroundColor: ColorsConst.dashboardButtonSlide,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                ),
                onPressed: () {
                  print("Btn user pressed!");
                },
                child: const FaIcon(
                  FontAwesomeIcons.plus,
                  color: Colors.white,
                  size: 20,
                )),
          ),
        ],
      ),
    );
  }
}
