// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:gym_management/pages/common/constants/ColorsConst.dart';
import 'package:gym_management/pages/dashboard_page/DashboardPage.dart';
import 'package:gym_management/pages/onBordingPages/onBordingP2.dart'; //falta colocar cache para se for a primeira vez entrando
import 'cpfEmail.dart';
import 'ncadastrado.dart';
import 'perguntas.dart';
import '../../pesquisaDb.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String userEmailCpf = "";
  Color btnColor = ColorsConst.btnLoginColor;
  Color corPergunta = Colors.white;

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
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 80),
          child: Column(
            children: [
              SizedBox(
                height: 150,
                width: 150,
                child: Image.asset('assets/img/logo.png'),
              ),
              const SizedBox(height: 75),
              SizedBox(
                width: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Usa ValueKey como cor para quando mudar a cor, caregar no mesmo elemento
                    PerguntaLogin(
                      key: ValueKey(corPergunta),
                      cor: corPergunta,
                      onValueChanged: (valor) {
                        setState(() {
                          userEmailCpf = valor;
                        });
                      },
                    ),
                    //falta colocar senha qui
                    const SizedBox(height: 225),
                    Center(
                      child: SizedBox(
                        width: 200,
                        height: 65,
                        child: ElevatedButton(
                          onPressed: () async {
                            int aux = checaResp(userEmailCpf);
                            setState(() {
                              if (aux == 0) {
                                corPergunta =
                                    Colors.red; // Muda a cor para vermelho
                              }
                            });
                            onPressedBtn();
                            if (aux != 0) {
                              if (await checkEmailOrCpf(userEmailCpf)) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const DashboardPage()),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const Ncadastrado()),
                                );
                              }
                            }
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
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
