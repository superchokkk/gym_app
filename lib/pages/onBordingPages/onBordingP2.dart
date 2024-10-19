import 'package:flutter/material.dart';
import 'package:gym_management/pages/common/constants/ColorsConst.dart';
import 'package:gym_management/pages/dashboard_page/DashboardPage.dart';

class Onbordingp2 extends StatefulWidget {
  const Onbordingp2({super.key});

  @override
  State<Onbordingp2> createState() => _Onbordingp2();
}

class _Onbordingp2 extends State<Onbordingp2> {
  //variavel e funcao onPressedBtn repeditas
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
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: ColorsConst.blacksBackgroundsSplashPage,
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      )),
      child: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Column(children: [
          SizedBox(
            height: 150,
            width: 150,
            child: Image.asset('assets/img/logo.png'),
          ),
          Container(
            width: 300,
            margin: const EdgeInsets.all(75.0),
            child: const Text(
              'Bem vindo ao seu novo app para uma vida melhor :)',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 80),
          Center(
            child: SizedBox(
            width: 200,
            height: 65,
            child: ElevatedButton(
              onPressed: () {
                onPressedBtn();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DashboardPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: btnColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Icon(
                      Icons.fitness_center,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Entrar',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Flexible(
                    child: Icon(
                      Icons.fitness_center,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ))
        ]),
      ),
    ));
  }
}
