import 'package:flutter/material.dart';
import 'package:gym_management/pages/common/constants/ColorsConst.dart';
import 'package:gym_management/pages/onBordingPages/onBordingP2.dart';
import 'package:gym_management/pages/login_page/LoginPage.dart';

class Onbordingp1 extends StatefulWidget {
  const Onbordingp1({super.key});

  @override
  State<Onbordingp1> createState() => _Onbordingp1();
}

class _Onbordingp1 extends State<Onbordingp1> {
  
  //variavel e funcao onPressedBtn repeditas
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
  Widget build(BuildContext context){
    double largura = MediaQuery.of(context).size.width;
    double altura  = MediaQuery.of(context).size.height;
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
          padding: const EdgeInsets.only(top: 0),
          child: Column(
            //esse botao
            children: [
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft, // Alinha no canto esquerdo
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: SizedBox(
                    width: largura * 0.14,
                    height: altura * 0.05,
                    child: ElevatedButton(
                      onPressed: () {
                        onPressedBtn();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: btnColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: const Text(
                        "X",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              
              SizedBox(
                height: 150,
                width: 150,
                child: Image.asset('assets/img/logo.png'),
              ),
              const SizedBox(height: 20),
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
                    const SizedBox(height: 50),
                    const Text(
                      'Confirme senha:',
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
                     
                    const SizedBox(height: 50),
                    Center(
                      child: SizedBox(
                        width: 200,
                        height: 65,
                        child: ElevatedButton(
                          onPressed: () {
                            onPressedBtn();
                            Navigator.push(
                              context, 
                              MaterialPageRoute(builder: (context) => const Onbordingp2()),
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
                                'Criar conta',
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