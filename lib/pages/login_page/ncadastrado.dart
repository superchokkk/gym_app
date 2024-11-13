import 'package:flutter/material.dart';
import 'package:gym_management/pages/common/constants/ColorsConst.dart';

class Ncadastrado extends StatefulWidget {
  const Ncadastrado({super.key});

  @override
  State<Ncadastrado> createState() => _Ncadastrado();
}

class _Ncadastrado extends State<Ncadastrado> {

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
              'Você ainda não esta cadastrado na melhor academia da cidade',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ]),
      ),
    ));
  }
}
