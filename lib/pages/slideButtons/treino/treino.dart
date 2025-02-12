import 'package:flutter/material.dart';
import 'package:gym_management/pages/common/constants/ColorsConst.dart';
import '../../../domain/models/Treino.dart';
import '../../../api/perguntasTreino.dart';
import '../../common/constants/ButtonConfig.dart';
import '../treino/exercicios.dart';
import '../../../api/dellAddTreino.dart';

class TreinoPage extends StatefulWidget {
  final int clienteId;
  const TreinoPage({
    Key? key,
    required this.clienteId,
  }) : super(key: key);

  @override
  _TreinosPageState createState() => _TreinosPageState();
}

class _TreinosPageState extends State<TreinoPage> {
  late Future<List<Treino>> treinosFuture;
  late ButtonConfigs btnconfg;
  TextEditingController _NameController = TextEditingController();
  int flagView = 0;

  @override
  void initState() {
    super.initState();
    treinosFuture = fetchTreinos(widget.clienteId);
    btnconfg = ButtonConfigs(identidificador: widget.clienteId);
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;

    void mudaFlag() {
      if (flagView == 0) {
        setState(() {
          flagView = 1;
        });
      } else {
        setState(() {
          flagView = 0;
        });
      }
    }

    Future<void> _confirmaDelet(int idTreino) async {
      bool? confirmDelete = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey[900],
            title: const Text(
              'Confirmar exclusão',
              style: TextStyle(color: Colors.white),
            ),
            content: const Text(
              'Deseja realmente excluir esse treino?',
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text(
                  'Cancelar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text(
                  'Excluir',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          );
        },
      );

      if (confirmDelete == true) {
        final success = await deletarTreino(idTreino);
        if (success) {
          setState(() {
            treinosFuture = fetchTreinos(widget.clienteId);
          });
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Treino excluído com sucesso!'),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 2),
              ),
            );
          }
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Erro ao excluir treino'),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 2),
              ),
            );
          }
        }
      }
    }

    void _showAddTreinoDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Novo Treino'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _NameController,
                  decoration: InputDecoration(
                    labelText: 'Nome do treino',
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancelar'),
              ),
              TextButton(
                onPressed: () async {
                  if (_NameController.text.isNotEmpty) {
                    bool success = await adicionarTreino(
                        widget.clienteId, _NameController.text);

                    if (success) {
                      Navigator.of(context).pop();
                      setState(() {
                        treinosFuture = fetchTreinos(widget.clienteId);
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Não foi possível adicionar Treino.'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                },
                child: Text('Salvar'),
              ),
            ],
          );
        },
      );
    }

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
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Stack(
            children: [
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
              Positioned(
                top: 30,
                right: 10,
                child: SizedBox(
                  width: 50,
                  height: 50,
                  //botão de excluir serie
                  child: ElevatedButton(
                    onPressed: () {
                      mudaFlag();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: const Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: FutureBuilder<List<Treino>>(
                  future: treinosFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                          child: Text(
                              'Erro ao carregar treinos: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                          child: Text('Nenhum treino encontrado.'));
                    } else {
                      final treinos = snapshot.data!;
                      return ListView.builder(
                        padding: const EdgeInsets.all(16.0),
                        itemCount: treinos.length,
                        itemBuilder: (context, index) {
                          final treino = treinos[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ExerciciosPage(
                                        treinoId: treino.id,
                                        treinoNome: treino.nome,
                                      ),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          treino.nome,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                screenWidth < 600 ? 16 : 18,
                                          ),
                                        ),
                                      ),
                                      if (flagView == 1)
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 16.0),
                                          child: SizedBox(
                                            width: 24,
                                            height: 24,
                                            child: IconButton(
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                                size: 24,
                                              ),
                                              onPressed: () =>
                                                  _confirmaDelet(treino.id),
                                              padding: EdgeInsets.zero,
                                              constraints:
                                                  const BoxConstraints(),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      //botão de adicionar
      floatingActionButton: Container(
        width: 56.0,
        height: 56.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [Colors.red, Colors.redAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.red.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: _showAddTreinoDialog,
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 32,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
