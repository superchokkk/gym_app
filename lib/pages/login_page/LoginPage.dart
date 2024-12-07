// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:gym_management/pages/common/constants/ColorsConst.dart';
import 'package:gym_management/pages/dashboard_page/DashboardPage.dart';
import 'package:gym_management/pages/onBordingPages/onBordingP2.dart';//adicionar algo para ver se é a primeira vez logando
import 'cpfEmail.dart';
import 'ncadastrado.dart';
import 'perguntas.dart';
import '../../../api/perguntasLogin.dart';
import '../../domain/models/Cliente.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Future<Cliente> futureClient;
  String userEmailCpf = "";
  Color btnColor = ColorsConst.btnLoginColor;
  Color corPergunta = Colors.white;

  Future<Cliente> ponteLogin(String ref) async {
    return obtemCliente(ref); // Busca os dados do cliente
  }

  Future<void> handleLogin() async {
    if (!checaResp(userEmailCpf)) {
      setState(() => corPergunta = Colors.red);
      return;
    }

    try {
      final cliente = await ponteLogin(userEmailCpf);
      if (cliente.id != false) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DashboardPage(cliente: cliente),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Ncadastrado(),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao fazer login: $e')),
      );
    }
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
                    PerguntaLogin(
                      key: ValueKey(corPergunta),
                      cor: corPergunta,
                      onValueChanged: (valor) {
                        setState(() {
                          userEmailCpf = valor;
                        });
                      },
                    ),
                    const SizedBox(height: 225),
                    Center(
                      child: SizedBox(
                        width: 201,
                        height: 65,
                        child: ElevatedButton(
                          onPressed: handleLogin, // Chama a função handleLogin
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
