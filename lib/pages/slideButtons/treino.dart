import 'package:flutter/material.dart';
import 'package:gym_management/pages/common/constants/ColorsConst.dart';
import 'package:gym_management/pages/login_page/LoginPage.dart';

class TreinoPage extends StatefulWidget {
  const TreinoPage({super.key});

  @override
  State<TreinoPage> createState() => _treino();
}

class _treino extends State<TreinoPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.transparent),
        gradient: const LinearGradient(
          colors: ColorsConst.blacksBackgroundsSplashPage,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )
      ),
      child: const Center(
      ),
    );
  }
}
