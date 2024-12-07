import 'package:flutter/material.dart';
import 'package:gym_management/pages/common/constants/ColorsConst.dart';
import 'package:gym_management/pages/dashboard_page/DashboardPage.dart';
import '../../domain/models/Cliente.dart';

class Onbordingp2 extends StatefulWidget {
  final Cliente cliente;
  const Onbordingp2({required this.cliente, super.key});

  @override
  State<Onbordingp2> createState() => _Onbordingp2State();
}

class _Onbordingp2State extends State<Onbordingp2> {
  Color btnColor = ColorsConst.btnLoginColor;

  void onPressedBtn() {
    setState(() {
      btnColor = ColorsConst.btnLoginColorPressed;
    });

    Future.delayed(const Duration(milliseconds: 150), () {
      setState(() {
        btnColor = ColorsConst.btnLoginColor;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    // Calculate responsive sizes
    final double logoSize = screenWidth * 0.3.clamp(100.0, 150.0);
    final double textWidth = screenWidth * 0.8.clamp(280.0, 400.0);
    final double buttonWidth = screenWidth * 0.5.clamp(180.0, 200.0);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: ColorsConst.blacksBackgroundsSplashPage,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.05,
                horizontal: screenWidth * 0.05,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: logoSize,
                    width: logoSize,
                    child: Image.asset('assets/img/logo.png'),
                  ),

                  Container(
                    width: textWidth,
                    margin: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.08,
                      horizontal: screenWidth * 0.05,
                    ),
                    child: Text(
                      'Bem vindo ao seu novo app para uma vida melhor :)',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth < 600 ? 20 : 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.08),

                  Center(
                    child: SizedBox(
                      width: buttonWidth,
                      height: 65,
                      child: ElevatedButton(
                        onPressed: () {
                          onPressedBtn();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DashboardPage(cliente: widget.cliente),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: btnColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Flexible(
                              child: Icon(
                                Icons.fitness_center,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Entrar',
                              style: TextStyle(
                                fontSize: screenWidth < 600 ? 16 : 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Flexible(
                              child: Icon(
                                Icons.fitness_center,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
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