import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym_management/pages/dashboard_page/navigation/NavigationItem.dart';
import '../../slideButtons/treino/treino.dart';
import '../../slideButtons/pagamento/status.dart';
import '../../slideButtons/profissionais/listaProficionais.dart' as profissionais;
import '../../slideButtons/clientes/listaClientes.dart';

class ButtonConfigs {
  final int identidificador;
  final int clienteNivel;

  ButtonConfigs({
    required this.identidificador,
    required this.clienteNivel,
  });

  List<NavigationItem> get dashboardNavigationItems {
    List<NavigationItem> items = [
      NavigationItem(
        text: 'Treinos',
        icon: FontAwesomeIcons.dumbbell,
        onPressed: (context) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TreinoPage(
                  clienteId: identidificador),
            ),
          );
        },
      ),
      NavigationItem(
        text: 'Profissionais',
        icon: FontAwesomeIcons.userTie,
        onPressed: (context) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => profissionais.ListaProfissionaisPage(),
            ),
          );
        },
      ),
      if (clienteNivel == 3)
        NavigationItem(
          text: 'Pagamentos',
          icon: FontAwesomeIcons.moneyBill,
          onPressed: (context) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StatusPage(clienteId: identidificador),
              ),
            );
          },
        ),
    ];
    if (clienteNivel != 3) {
      items.add(
        NavigationItem(
          text: 'Clientes',
          icon: FontAwesomeIcons.users,
          onPressed: (context) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ListaclientesPage(idAcesso: identidificador),
              ),
            );
          },
        ),
      );
    }
    if (clienteNivel == 1) {
      items.add(
        NavigationItem(
          text: '+Profissionais',
          icon: FontAwesomeIcons.userPen,
          onPressed: (context) {
            Navigator.pushNamed(context, '/treino');
          },
        ),
      );
    }
    return items;
  }

  List<Map<String, dynamic>> get dashboardSliderButtonsConfig => [
        {
          'text': 'Adicionar Treino',
          'onPressed': () {
            print('Botão de adicionar treino pressionado');
          },
        }
      ];
}
