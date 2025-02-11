import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:gym_management/pages/common/constants/ColorsConst.dart';
import '../../../api/perguntaEspecifico.dart';
import '../../../domain/models/ExercicioData.dart';
import '../../../api/dellAddEspecifico.dart';

class EspecificoPage extends StatefulWidget {
  final int treinoId;
  final int exercicioId;
  final String exercicioNome;

  const EspecificoPage({
    Key? key,
    required this.treinoId,
    required this.exercicioId,
    required this.exercicioNome,
  }) : super(key: key);

  @override
  _EspecificoPageState createState() => _EspecificoPageState();
}

class _EspecificoPageState extends State<EspecificoPage> {
  late Future<List<ExercicioData>> exercisesFuture;
  int flagView = 0;
  final TextEditingController _repsController = TextEditingController();
  final TextEditingController _pesoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    exercisesFuture = fetchEspecifico(widget.treinoId, widget.exercicioId);
  }
  @override
  void dispose() {
    _repsController.dispose();
    _pesoController.dispose();
    super.dispose();
  }

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

  Map<String, List<ExercicioData>> _agrupamentoData(
      List<ExercicioData> exercises) {
    Map<String, List<ExercicioData>> agrupados = {};
    for (var exercise in exercises) {
      if (!agrupados.containsKey(exercise.data)) {
        agrupados[exercise.data] = [];
      }
      agrupados[exercise.data]!.add(exercise);
    }
    return agrupados;
  }

  Future<void> _confirmaDelet(ExercicioData exercise) async {
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
            'Deseja realmente excluir essa serie?',
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
      final success = await deletaEspecifico(exercise.id);
      if (success) {
        setState(() {
          exercisesFuture =
              fetchEspecifico(widget.treinoId, widget.exercicioId);
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

  Future<void> _showAddSerieDialog() async {
  _repsController.clear();
  _pesoController.clear();
  
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text(
          'Adicionar Série',
          style: TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _repsController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Repetições',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _pesoController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Peso (kg)',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancelar',
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () {
              if (_repsController.text.isNotEmpty && _pesoController.text.isNotEmpty) {
                adicionarEspecifico(
                  widget.treinoId,
                  widget.exercicioId,
                  int.parse(_repsController.text),
                  int.parse(_pesoController.text),
                );
                
                setState(() {
                  exercisesFuture = fetchEspecifico(widget.treinoId, widget.exercicioId);
                });
                
                Navigator.pop(context);
                
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Série adicionada com sucesso!'),
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
            child: const Text(
              'Adicionar',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;

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
        child: Align(
          alignment: Alignment.topCenter,
          child: FractionallySizedBox(
            widthFactor: 1,
            heightFactor: 0.80,
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
                          widget.exercicioNome,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: FutureBuilder<List<ExercicioData>>(
                          future: exercisesFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text(
                                  'Erro ao carregar exercícios: ${snapshot.error}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              );
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return const Center(
                                child: Text(
                                  'Nenhum exercício encontrado.',
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                            }

                            final groupedExercises =
                                _agrupamentoData(snapshot.data!);
                            final dates = groupedExercises.keys.toList()
                              ..sort((a, b) => b.compareTo(a));

                            return ListView.builder(
                              padding: const EdgeInsets.all(16.0),
                              itemCount: dates.length,
                              itemBuilder: (context, index) {
                                final date = dates[index];
                                final exercisesForDate =
                                    groupedExercises[date]!;

                                return Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8,
                                        horizontal: 16,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        DateFormat('dd/MM/yyyy')
                                            .format(DateTime.parse(date)),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    ...exercisesForDate
                                        .map((exercise) => Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                vertical: 8.0,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        '${exercise.reps} reps - ${exercise.peso}kg',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize:
                                                              screenWidth < 600
                                                                  ? 16
                                                                  : 18,
                                                        ),
                                                      ),
                                                    ),
                                                    if (flagView == 1)
                                                      SizedBox(
                                                        width: 50,
                                                        height: 23,
                                                        //botão de deletar
                                                        child: ElevatedButton(
                                                          onPressed: () =>
                                                              _confirmaDelet(
                                                                  exercise),
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            shadowColor: Colors
                                                                .transparent,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                            ),
                                                          ),
                                                          child: const Icon(
                                                            Icons.delete,
                                                            color: Colors.red,
                                                          ),
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                    const SizedBox(height: 16),
                                  ],
                                );
                              },
                            );
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
          onPressed: () {
            _showAddSerieDialog();
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