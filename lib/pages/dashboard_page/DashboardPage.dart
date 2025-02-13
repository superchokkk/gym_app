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
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFF121212),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: screenHeight,
              ),
              child: Column(
                children: <Widget>[
                  // Header
                  DashboardHeader(cliente: widget.cliente),

                  // Navigation
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.02,
                      horizontal: 16,
                    ),
                    child: DashboardNavigation(
                        clienteId: widget.cliente.id,
                        clienteNivel: widget.cliente.nivel),
                  ),

                  // Slides
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.01,
                      horizontal: 8,
                    ),
                    child: DashboardSlider(
                        clienteId: widget.cliente.id,
                        clienteNivel: widget.cliente.nivel),
                  ),

                  // Footer buttons
                  Padding(
                    padding: EdgeInsets.only(
                      top: screenHeight * 0.03,
                      bottom: screenHeight * 0.02,
                    ),
                    child: const Center(
                      child: DashboardFooter(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
