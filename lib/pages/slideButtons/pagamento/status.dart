import 'package:flutter/material.dart';
import 'package:gym_management/pages/common/constants/ColorsConst.dart';
import '../../../domain/models/Cliente.dart';
import '../../../api/mudarStatus.dart';


class StatusPage extends StatefulWidget {
  final int clienteId;

  const StatusPage({
    Key? key,
    required this.clienteId,
  }) : super(key: key);

  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  late Future<Cliente> clienteFuture;

  @override
  void initState() {
    super.initState();
    clienteFuture = fecthClientesId(widget.clienteId);
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
        child: Stack(
          children: [
            //botão de voltar
            Positioned(
              top: 30,
              left: 10,
              child: SizedBox(
                width: 70,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.05,
                  left: 16,
                  right: 16,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Status',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    FutureBuilder<Cliente>(
                      future: clienteFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator(
                              color: Colors.white);
                        } else if (snapshot.hasError) {
                          return Text(
                            'Erro ao carregar dados: ${snapshot.error}',
                            style: const TextStyle(color: Colors.red),
                          );
                        } else if (snapshot.hasData) {
                          final cliente = snapshot.data!;
                          final now = DateTime.now();

                          final dataParts = cliente.data.split('/');
                          final clienteData = DateTime(
                              int.parse(dataParts[1]),
                              int.parse(dataParts[0]),
                              1
                              );

                          String statusText;
                          Color statusColor;

                          if (clienteData.year == now.year &&
                              clienteData.month == now.month) {
                            statusText = "Pago";
                            statusColor = Colors.green;
                          } else if (clienteData.year == now.year &&
                              clienteData.month == now.month - 1) {
                            statusText = "Em aberto";
                            statusColor = Colors.yellow;
                          } else {
                            statusText = "Atrasado";
                            statusColor = Colors.red;
                          }

                          return SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize
                                  .min,
                              children: [
                                Text(
                                  'Cliente: ${cliente.nome}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      statusText,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      width: 12,
                                      height: 12,
                                      decoration: BoxDecoration(
                                        color: statusColor,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 24),
                                ElevatedButton(
                                    onPressed: () async {
                                    await atualizarDataPgto(cliente.id);
                                    setState(() {
                                      clienteFuture = fecthClientesId(widget.clienteId);
                                    });
                                    },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red[900],
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 32,
                                      vertical: 16,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    'Pagar',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return const Text(
                            'Nenhum dado encontrado',
                            style: TextStyle(color: Colors.white),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
