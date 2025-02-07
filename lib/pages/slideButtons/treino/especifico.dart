import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:gym_management/pages/common/constants/ColorsConst.dart';
import '../../../api/perguntaEspecifico.dart';
import '../../../domain/models/ExercicioData.dart';

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

  @override
  void initState() {
    super.initState();
    exercisesFuture = fetchEspecifico(widget.treinoId, widget.exercicioId);
  }

  Map<String, List<ExercicioData>> _groupByDate(List<ExercicioData> exercises) {
    Map<String, List<ExercicioData>> grouped = {};
    for (var exercise in exercises) {
      if (!grouped.containsKey(exercise.data)) {
        grouped[exercise.data] = [];
      }
      grouped[exercise.data]!.add(exercise);
    }
    return grouped;
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
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              'Erro ao carregar exercícios: ${snapshot.error}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(
                            child: Text(
                              'Nenhum exercício encontrado.',
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }

                        final groupedExercises = _groupByDate(snapshot.data!);
                        final dates = groupedExercises.keys.toList()
                          ..sort((a, b) => b.compareTo(a));

                        return ListView.builder(
                          padding: const EdgeInsets.all(16.0),
                          itemCount: dates.length,
                          itemBuilder: (context, index) {
                            final date = dates[index];
                            final exercisesForDate = groupedExercises[date]!;

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                ...exercisesForDate.map((exercise) => Container(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      '${exercise.reps} reps - ${exercise.peso}kg',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: screenWidth < 600 ? 16 : 18,
                                      ),
                                    ),
                                  ),
                                )).toList(),
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
    );
  }
}
