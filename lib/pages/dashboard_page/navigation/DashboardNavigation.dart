// ignore_for_file: file_names

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:gym_management/pages/common/constants/button_configs.dart';
import 'package:gym_management/pages/dashboard_page/navigation/DashboardNavigationItems.dart';

class DashboardNavigation extends StatelessWidget {

  DashboardNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: double.infinity,
      child: ListView.builder(       
        itemCount: dashboardNavigationItems.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final item = dashboardNavigationItems[index];
          return DashboardNavigationItems(
            itemText: Text(
              item.text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            icon: FaIcon(
              item.icon,
              color: Colors.white,
              size: 25,
            ),
            onPressed: item.onPressed,
          );
        },
      ),
    );
  }
}
