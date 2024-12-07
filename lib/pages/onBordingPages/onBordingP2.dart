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
  // Variáveis para alterar a cor do botão
  Color btnColor = ColorsConst.btnLoginColor;

  void onPressedBtn() {
    setState(() {
      btnColor = ColorsConst.btnLoginColorPressed;
    });

    // Reseta a cor do botão após um curto delay
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
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Column(
            children: [
              // Logo
              SizedBox(
                height: 150,
                width: 150,
                child: Image.asset('assets/img/logo.png'),
              ),

              // Mensagem de boas-vindas
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

              // Botão de navegação
              Center(
                child: SizedBox(
                  width: 200,
                  height: 65,
                  child: ElevatedButton(
                    onPressed: () {
                      onPressedBtn();

                      // Navegação para a DashboardPage com o objeto Cliente
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
                      children: const [
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
