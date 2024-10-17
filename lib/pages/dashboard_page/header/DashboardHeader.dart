// ignore_for_file: file_names

import 'package:flutter/material.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ), 
              ),
              child: const Stack(
                children: [
                  Image(
                    image: AssetImage('assets/img/dashimage.png'),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 250,
                  ),
                  Positioned(
                    top: 185,
                    left: 20,
                    child: Text(
                      'Olá, Junior!',
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
