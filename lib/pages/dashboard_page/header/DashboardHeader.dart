// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:gym_management/pages/login_page/LoginPage.dart';
import '../../../domain/models/Cliente.dart';

class DashboardHeader extends StatelessWidget {
  final Cliente cliente;
  const DashboardHeader({required this.cliente, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Stack(
        children: [
          Image(
            image: AssetImage('assets/img/dashimage.png'),
            fit: BoxFit.cover,
            width: double.infinity,
            height: 250,
          ),
          Align(
            alignment: Alignment.centerLeft, // Alinha no canto esquerdo
            child: Padding(
              padding: const EdgeInsets.only(top: 18, left: 18),
              child: SizedBox(
                width: 85,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 195, 13, 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                  child: const Text(
                    "Sair",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 185,
            left: 20,
            child: Text(
              'Ola, ${cliente.nome}!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
