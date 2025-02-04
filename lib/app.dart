import 'package:flutter/material.dart';
import 'package:gym_management/pages/splash_page/splash_page.dart';
import 'pages/slideButtons/treino/treino.dart';

class GymManagementApp extends StatelessWidget {
  const GymManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gym Management',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const SafeArea(child: SplashPage()),
    );
  }
}
