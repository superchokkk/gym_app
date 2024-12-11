// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym_management/pages/dashboard_page/navigation/NavigationItem.dart';
import '../../slideButtons/treino.dart';

class ButtonConfigs {
  final int clienteId;
  
  ButtonConfigs({required this.clienteId});

  List<NavigationItem> get dashboardNavigationItems => [
    NavigationItem(
      text: 'Evolução',
      icon: FontAwesomeIcons.dumbbell,
      onPressed: (context) {
        Navigator.pushNamed(context, '/treino');
      },
    ),
    NavigationItem(
      text: 'Treinos',
      icon: FontAwesomeIcons.dumbbell,
      onPressed: (context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TreinoPage(clienteId: clienteId),
          ),
        );
      },
    ),
    NavigationItem(
      text: 'Pagamentos',
      icon: FontAwesomeIcons.dumbbell,
      onPressed: (context) {
        Navigator.pushNamed(context, '/treino');
      },
    ),
    NavigationItem(
      text: 'Profissionais',
      icon: FontAwesomeIcons.dumbbell,
      onPressed: (context) {
        Navigator.pushNamed(context, '/treino');
      },
    ),
    NavigationItem(
      text: 'Ajuda',
      icon: FontAwesomeIcons.dumbbell,
      onPressed: (context) {
        Navigator.pushNamed(context, '/treino');
      },
    ),
  ];

  List<Map<String, dynamic>> get dashboardSliderButtonsConfig => [
    {
      'text': 'Solicitar Avaliação',
      'onPressed': () {
        print('Botão de avaliação de aluno pressionado');
      },
    },
    {
      'text': 'Adicionar Treino',
      'onPressed': () {
        print('Botão de adicionar treino pressionado');
      },
    }
  ];
}