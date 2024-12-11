import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gym_management/pages/common/constants/ColorsConst.dart';
import 'package:gym_management/pages/dashboard_page/DashboardPage.dart';
import 'perguntas.dart';
import '../../domain/models/Cliente.dart';
import 'LoginPage.dart';

class Senhapage extends StatefulWidget {
  final Cliente cliente;
  const Senhapage({required this.cliente, super.key});

  @override
  State<Senhapage> createState() => _senhaPage();
}

class _senhaPage extends State<Senhapage> {
  String senha = "";
  Color btnColor = ColorsConst.btnLoginColor;
  Color corPergunta = Colors.white;

  Future<void> handleLogin() async {
    if(widget.cliente.senha == senha){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DashboardPage(cliente: widget.cliente),
          ),
        );
    }else{
      setState(() => corPergunta = Colors.red);
    }
  }

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
            SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: screenHeight,
                ),
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      horizontalPadding,
                      topPadding,
                      horizontalPadding,
                      20,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: actualLogoSize,
                          width: actualLogoSize,
                          child: Image.asset('assets/img/logo.png'),
                        ),
                        SizedBox(height: screenHeight * 0.08),
                        ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 600),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PerguntaLogin(
                                key: ValueKey(corPergunta),
                                cor: corPergunta,
                                labelText: 'Senha',
                                onValueChanged: (valor) {
                                  setState(() {
                                    senha = valor;
                                  });
                                },
                              ),
                              SizedBox(height: screenHeight * 0.15),
                              Center(
                                child: SizedBox(
                                  width: screenWidth < 600 ? screenWidth * 0.6 : 201,
                                  height: 65,
                                  child: ElevatedButton(
                                    onPressed: handleLogin,
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
                      ],
                    ),
                  ),
                ),
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
                    shadowColor: Colors.transparent,
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
      ),
    );
  }
}