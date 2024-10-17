import 'package:flutter/material.dart';
import 'package:gym_management/pages/common/constants/ColorsConst.dart';
import 'package:gym_management/pages/login_page/LoginPage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context, 
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });
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
        child: Image(
          image: AssetImage('assets/img/logo.png'), 
          width: 150, 
          height: 150,
        ),
      ),
    );
  }
}
