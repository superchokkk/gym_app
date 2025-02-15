// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym_management/pages/dashboard_page/footer/buttons/FooterButtons.dart';
import 'package:gym_management/pages/dashboard_page/footer/contatoGym.dart';

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
      child: FooterButton(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        width: width,
        height: height,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ContatoGymPage(),
              ),
            );
        },
        icon: FontAwesomeIcons.addressBook,
      ),
    );
  }
}
