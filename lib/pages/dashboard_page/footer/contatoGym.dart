import 'package:flutter/material.dart';
import 'package:gym_management/pages/common/constants/ColorsConst.dart';
import '../../../api/mudarStatus.dart';
import '../../../domain/models/Cliente.dart';

class ContatoGymPage extends StatefulWidget {
  const ContatoGymPage({Key? key}) : super(key: key);

  @override
  State<ContatoGymPage> createState() => _ContatoGymPageState();
}

class _ContatoGymPageState extends State<ContatoGymPage> {
  late Future<Cliente> clienteFuture;

  @override
  void initState() {
    super.initState();
    clienteFuture = fecthClientesId(1);
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: ColorsConst.blacksBackgroundsSplashPage,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(screenHeight * 0.2),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            flexibleSpace: Padding(
              padding: EdgeInsets.only(
                top: screenHeight * 0.1,
                left: 16,
                right: 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 28,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text(
                    'Contato Academia',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 48), // Balance the layout
                ],
              ),
            ),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: ColorsConst.blacksBackgroundsSplashPage,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: FutureBuilder<Cliente>(
              future: clienteFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(color: Colors.red);
                }

                if (snapshot.hasError) {
                  return Text(
                    'Erro ao carregar dados: ${snapshot.error}',
                    style: const TextStyle(color: Colors.white),
                  );
                }

                if (!snapshot.hasData || snapshot.data == null) {
                  return const Text(
                    'Nenhum dado encontrado',
                    style: TextStyle(color: Colors.white),
                  );
                }

                final cliente = snapshot.data!;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      cliente.nome,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      cliente.email,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
