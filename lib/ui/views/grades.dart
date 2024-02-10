import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goipvc/models/myipvc/grade.dart';
import 'package:goipvc/providers/final_grade_provider.dart';
import 'package:goipvc/providers/grades_provider.dart';
import 'package:goipvc/ui/views/error.dart';
import 'package:goipvc/ui/views/loading.dart';

import '../widgets/grade_card.dart';

class GradesView extends ConsumerWidget {
  const GradesView({super.key});

  final bottomSheet = const SizedBox(
    height: 250,
    child: Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                'Como é calculada a média global?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'A média é calculada tendo em consideração a nota da Unidade Curricular e os seus respetivos ECTS.',
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Primeiro obtém-se o somatório das notas das UCs multiplicadas pelos seus ECTS. De seguida, divide-se esse valor pelo somatório dos ECTS das UCs.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<MyIPVCGrade>> grades = ref.watch(gradesProvider);
    AsyncValue<double> finalGrade = ref.watch(finalGradeProvider);

    if (grades.isRefreshing || finalGrade.isRefreshing) {
      return const LoadingView();
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Avaliações")),
      body: grades.when(
          loading: () => const LoadingView(),
          error: (err, stack) => ErrorView(
                error: "$err",
                callback: () {
                  grades = ref.refresh(gradesProvider);
                },
              ),
          data: (grades) {
            return finalGrade.when(
                error: (err, stack) => ErrorView(
                      error: "$err",
                      callback: () {
                        finalGrade = ref.refresh(finalGradeProvider);
                      },
                    ),
                data: (finalGrade) {
                  if (finalGrade == -1) {
                    return const Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.info, size: 48),
                        Text("Não existem avaliações",
                            textAlign: TextAlign.center)
                      ],
                    ));
                  }

                  return Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 40),
                    child: ListView(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            const Text("Média global",
                                style: TextStyle(fontSize: 32)),
                            const Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 8)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  finalGrade.toStringAsPrecision(4),
                                  style: const TextStyle(fontSize: 24),
                                ),
                                IconButton(
                                  onPressed: () {
                                    showModalBottomSheet<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return bottomSheet;
                                      },
                                    );
                                  },
                                  icon: const Icon(Icons.info),
                                )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Column(
                          children: <Widget>[
                            for (var grade in grades) GradeCard(grade: grade)
                          ],
                        )
                      ],
                    ),
                  );
                },
                loading: () => const LoadingView());
          }),
    );
  }
}
