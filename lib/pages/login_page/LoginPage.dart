// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:gym_management/pages/common/constants/ColorsConst.dart';
import 'package:gym_management/pages/dashboard_page/DashboardPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage ({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  Color btnColor = ColorsConst.btnLoginColor;

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
          )
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
              const SizedBox(height: 40),
              SizedBox(
                width: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Email:', 
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Center(
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 1.5),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 1.5),
                          ),
                        ),
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    const Text(
                      'Senha:',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),
                     ),
                     const Center(
                      child: SizedBox(
                        width: 300,
                        child: TextField(
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white, width: 1.5),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white, width: 1.5),
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                      ),
                     ),
                    const SizedBox(height: 80),
                    Center(
                      child: SizedBox(
                        width: 200,
                        height: 65,
                        child: ElevatedButton(
                          onPressed: () {
                            onPressedBtn();
                            Navigator.push(
                              context, 
                              MaterialPageRoute(builder: (context) => const DashboardPage()),
                            );
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
                              Flexible(child: 
                                Icon(
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
                              Flexible(child: 
                                Icon(
                                  Icons.fitness_center,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ),
                    SizedBox(
                      child: Center(
                        child: TextButton(
                          onPressed: () {
                            print("esqueceu a senha?");
                          },
                          child: const Text(
                            'Esqueceu a senha?',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
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
