import 'package:flutter/material.dart';
import 'package:gym_management/api/perguntaGrupo.dart';
import 'package:gym_management/api/perguntasExercicio.dart';
import 'package:gym_management/domain/models/ExercicioGrupo.dart';
import 'package:gym_management/pages/common/constants/ColorsConst.dart';
import '../../../api/dellAddExercicios.dart';

class ListaExercicios extends StatefulWidget {
  final int treinoId;
  final String treinoNome;

  const ListaExercicios({
    Key? key,
    required this.treinoId,
    required this.treinoNome,
  }) : super(key: key);

  @override
  _ListaExerciciosState createState() => _ListaExerciciosState();
}

class _ListaExerciciosState extends State<ListaExercicios> {
  late Future<List<ExercicioGrupo>> exercisesFuture;

  @override
  void initState() {
    super.initState();
    //listar todos os exercicios
    exercisesFuture = fetchExercicioAll();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    TextEditingController _groupNameController = TextEditingController();
    TextEditingController _exerciseNameController = TextEditingController();

    Map<int, List<ExercicioGrupo>> _agrupamentoPorGrupo(
        List<ExercicioGrupo> exercises) {
      Map<int, List<ExercicioGrupo>> agrupados = {};

      for (var exercise in exercises) {
        if (!agrupados.containsKey(exercise.id_grupo)) {
          agrupados[exercise.id_grupo] = [];
        }
        agrupados[exercise.id_grupo]!.add(exercise);
      }

      return agrupados;
    }

    void _showAddSerieDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Adicionar Novo Exercício'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _groupNameController,
                  decoration: InputDecoration(
                    labelText: 'Nome do Grupo Muscular',
                    hintText: 'Ex: peito, costas, pernas',
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _exerciseNameController,
                  decoration: InputDecoration(
                    labelText: 'Nome do Exercício',
                    hintText: 'Ex: Supino, Agachamento',
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
                  if (_groupNameController.text.isNotEmpty &&
                      _exerciseNameController.text.isNotEmpty) {
                    bool success = await achaGrupo(_exerciseNameController.text,
                        _groupNameController.text);

                    if (success) {
                      Navigator.of(context).pop();
                      setState(() {
                        exercisesFuture = fetchExercicioAll();
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Erro: Grupo muscular não encontrado'),
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
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "Exercícios",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: FutureBuilder<List<ExercicioGrupo>>(
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
                                _agrupamentoPorGrupo(snapshot.data!);
                            final grupos = groupedExercises.keys.toList()
                              ..sort((a, b) => b.compareTo(a));

                            return ListView.builder(
                              padding: const EdgeInsets.all(16.0),
                              itemCount: grupos.length,
                              itemBuilder: (context, index) {
                                final grupo = grupos[index];
                                final exercisesPorGrupo =
                                    groupedExercises[grupo]!;

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
                                        exercisesPorGrupo[0].nome_grupo ??
                                            'Grupo sem nome',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    ...exercisesPorGrupo
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
                                                      child: TextButton(
                                                        onPressed: () async {
                                                          try {
                                                            await adicionarExercicio(
                                                                widget.treinoId,
                                                                exercise.id);
                                                            if (context
                                                                .mounted) {
                                                              Navigator.pop(
                                                                  context,
                                                                  true);
                                                            }
                                                          } catch (e) {
                                                            print(
                                                                'Error adding exercise: $e');
                                                            if (context
                                                                .mounted) {
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                SnackBar(
                                                                    content: Text(
                                                                        'Erro ao adicionar exercício')),
                                                              );
                                                            }
                                                          }
                                                        },
                                                        style: TextButton
                                                            .styleFrom(
                                                          padding:
                                                              EdgeInsets.zero,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                        ),
                                                        child: Text(
                                                          '${exercise.nome}',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                screenWidth <
                                                                        600
                                                                    ? 16
                                                                    : 18,
                                                          ),
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
          onPressed: _showAddSerieDialog,
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
