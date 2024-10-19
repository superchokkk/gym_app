// ignore_for_file: file_names

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym_management/pages/dashboard_page/navigation/NavigationItem.dart';

class ButtonConfigs {
  final List<NavigationItem> dashboardNavigationItems= [
    NavigationItem(
      text: 'Evolução',
      icon: FontAwesomeIcons.chartSimple,
      onPressed: () {
        print('BTN PRESSED - Evolução');
      },
    ),
    NavigationItem(
      text: 'Treinos',
      icon: FontAwesomeIcons.dumbbell,
      onPressed: () {
        print('BTN PRESSED - Treinos');
      },
    ),
    NavigationItem(
      text: 'Pagamentos',
      icon: FontAwesomeIcons.dollarSign,
      onPressed: () {
        print('BTN PRESSED');
      },
    ),
    NavigationItem(
      text: 'Profissionais',
      icon: FontAwesomeIcons.users,
      onPressed: () {
        print('BTN PRESSED');
      },
    ),
    NavigationItem(
      text: 'Ajuda',
      icon: FontAwesomeIcons.circleInfo,
      onPressed: () {
        print('BTN PRESSED');
      },
    ),
  ];

  final List<Map<String, dynamic>> dashboardSliderButtonsConfig = [
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
