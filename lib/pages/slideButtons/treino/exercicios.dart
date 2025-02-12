import 'package:flutter/material.dart';
import 'package:gym_management/pages/common/constants/ColorsConst.dart';
import '../../../domain/models/Exercicio.dart';
import '../../../api/perguntasExercicio.dart';
import '../treino/especifico.dart';
import '../../../api/dellAddExercicios.dart';
import '../treino/listaExercicios.dart';

class ExerciciosPage extends StatefulWidget {
  final int treinoId;
  final String treinoNome;

  const ExerciciosPage({
    Key? key,
    required this.treinoId,
    required this.treinoNome,
  }) : super(key: key);

  @override
  _ExerciciosPageState createState() => _ExerciciosPageState();
}

class _ExerciciosPageState extends State<ExerciciosPage> {
  late Future<List<Exercicio>> exerciciosFuture;
  int flagView = 0;

  @override
  void initState() {
    super.initState();
    exerciciosFuture = fetchExercicio(widget.treinoId);
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;

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

    Future<void> _confirmaDelet(Exercicio exercise) async {
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
              'Deseja realmente excluir esse exercicio?',
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
        final success = await deletarExercicio(widget.treinoId, exercise.id);
        if (success) {
          setState(() {
            exerciciosFuture = fetchExercicio(widget.treinoId);
          });
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Exercício excluído com sucesso!'),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 2),
              ),
            );
          }
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Erro ao excluir exercício'),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 2),
              ),
            );
          }
        }
      }
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
                  //botão de voltar
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
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        widget.treinoNome,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: FutureBuilder<List<Exercicio>>(
                        future: exerciciosFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text(
                                    'Erro ao carregar exercícios: ${snapshot.error}'));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Center(
                                child: Text('Nenhum exercício encontrado.'));
                          } else {
                            final exercicios = snapshot.data!;
                            return ListView.builder(
                              padding: const EdgeInsets.all(16.0),
                              itemCount: exercicios.length,
                              itemBuilder: (context, index) {
                                final exercicio = exercicios[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EspecificoPage(
                                          treinoId: widget.treinoId,
                                          exercicioId: exercicio.id,
                                          exercicioNome: exercicio.nome,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0),
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            exercicio.nome,
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
                                                    _confirmaDelet(exercicio),
                                                padding: EdgeInsets.zero,
                                                constraints:
                                                    const BoxConstraints(),
                                              ),
                                            ),
                                          )
                                      ],
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
    onPressed: () async {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ListaExercicios(
            treinoId: widget.treinoId,
            treinoNome: widget.treinoNome,
          ),
        ),
      );
      if (result == true && mounted) {
        setState(() {
          exerciciosFuture = fetchExercicio(widget.treinoId);
        });
      }
    },
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
