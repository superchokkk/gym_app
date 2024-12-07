// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:gym_management/pages/dashboard_page/footer/DashboardFooter.dart';
import 'package:gym_management/pages/dashboard_page/header/DashboardHeader.dart';
import 'package:gym_management/pages/dashboard_page/navigation/DashboardNavigation.dart';
import 'package:gym_management/pages/dashboard_page/slider/DashboardSlider.dart';
import '../../domain/models/Cliente.dart';

class DashboardPage extends StatefulWidget {
  final Cliente cliente;
  const DashboardPage({required this.cliente, super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFF121212),
        ),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              // # Header
              DashboardHeader(cliente: widget.cliente),
              // # NAVIGATION
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 25),
                child: DashboardNavigation(),
              ),
              // # SLIDES
              const Padding(
                padding: EdgeInsets.only(top: 5, right: 1),
                child: DashboardSlider(),
              ),
              // # FOOTER BUTTONS
              const Padding(
                padding: EdgeInsets.only(top: 25),
                child: Center(
                  child: DashboardFooter(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
