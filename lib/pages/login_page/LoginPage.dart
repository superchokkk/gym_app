// ignore_for_file: file_names

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gym_management/pages/common/constants/ColorsConst.dart';
import 'package:gym_management/pages/login_page/senhaPage.dart';
import 'cpfEmail.dart';
import 'ncadastrado.dart';
import 'perguntas.dart';
import '../../../api/perguntasLogin.dart';
import '../../domain/models/Cliente.dart';
import '../login_page/vencido.dart';

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
    return fecthClientes(ref);
  }

  Future<void> handleLogin() async {
    if (!checaResp(userEmailCpf)) {
      setState(() => corPergunta = Colors.red);
      return;
    }

    try {
      final cliente = await ponteLogin(userEmailCpf);
      if (cliente.id != 0) {
        //ver status do cliente
        final now = DateTime.now();
        final dataParts = cliente.data.split('/');
        final clienteData = DateTime(
          int.parse(dataParts[2]), // ano
          int.parse(dataParts[1]), // mês
          int.parse(dataParts[0]), // dia
        );
        if (clienteData.year == now.year && clienteData.month == now.month ||
            clienteData.year == now.year && clienteData.month == now.month - 1) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Senhapage(cliente: cliente),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => VencidoPage(),
            ),
          );
        }
        //---------------------
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
        child: SingleChildScrollView(
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
                            labelText: 'cpf',
                            onValueChanged: (valor) {
                              setState(() {
                                userEmailCpf = valor;
                              });
                            },
                          ),
                          SizedBox(height: screenHeight * 0.15),
                          Center(
                            child: SizedBox(
                              width:
                                  screenWidth < 600 ? screenWidth * 0.6 : 201,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
      ),
    );
  }
}
