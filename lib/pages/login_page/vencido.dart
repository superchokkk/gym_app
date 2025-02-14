import 'package:flutter/material.dart';
import 'package:gym_management/pages/common/constants/ColorsConst.dart';
import 'LoginPage.dart';

class VencidoPage extends StatefulWidget {
  const VencidoPage({super.key});

  @override
  State<VencidoPage> createState() => _VencidoPageStatus();
}

class _VencidoPageStatus extends State<VencidoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: ColorsConst.blacksBackgroundsSplashPage,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                SizedBox(
                  height: 150,
                  width: 150,
                  child: Image.asset('assets/img/logo.png'),
                ),
                Container(
                  width: 300,
                  margin: const EdgeInsets.all(75.0),
                  child: const Text(
                    'Infelizmente seu plano venceu, entre em contato com a academia para renovar seu plano :)',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 40,
            left: 10,
            child: SizedBox(
              width: 70,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent, // Remove a sombra do botão
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
