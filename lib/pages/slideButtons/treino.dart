import 'package:flutter/material.dart';
import 'package:gym_management/pages/common/constants/ColorsConst.dart';
import '../../domain/models/Treino.dart';
import '../../api/perguntasTreino.dart';

class TreinoPage extends StatefulWidget {
  final int clienteId;
  const TreinoPage({
    Key? key,
    required this.clienteId,
  }) : super(key: key);


  @override
  _TreinosPageState createState() => _TreinosPageState();
}

class _TreinosPageState extends State<TreinoPage> {
  late Future<List<Treino>> _treinosFuture;
  
  Color btnColor = ColorsConst.btnLoginColor;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    double screenWidth = screenSize.width;

    final double logoSize = screenWidth * 0.3;
    final double maxLogoSize = 150.0;
    final double minLogoSize = 100.0;
    final double actualLogoSize = logoSize.clamp(minLogoSize, maxLogoSize);

    final double topPadding = screenHeight * 0.1;
    final double horizontalPadding = screenWidth * 0.05;

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
        child: Stack(
          children: [
            
          ],
        ),
      ),
    );
  }
}