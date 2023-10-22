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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<MyIPVCGrade>> grades = ref.watch(gradesProvider);
    AsyncValue<double> finalGrade = ref.watch(finalGradeProvider);

    if(grades.isRefreshing || finalGrade.isRefreshing){
      return const LoadingView();
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Avaliações")),
      body: grades.when(
          loading: () => const LoadingView(),
          error: (err, stack) => ErrorView(
            error: "$err",
            callback: () {grades = ref.refresh(gradesProvider);},
          ),
          data: (grades) {
            return finalGrade.when(
                error: (err, stack) => ErrorView(
                  error: "$err",
                  callback: () {finalGrade = ref.refresh(finalGradeProvider);},
                ),
                data: (finalGrade) {
                  if(finalGrade == -1) {
                    return const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.info, size: 48),
                            Text("Não existem avaliações", textAlign: TextAlign.center)
                          ],
                        )
                    );
                  }

                  return ListView(
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                          child: Column(
                            children: <Widget>[
                              const Text("Média global", style: TextStyle(fontSize: 32)),
                              const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 8)),
                              Text(
                                finalGrade.toStringAsPrecision(4),
                                style: const TextStyle(fontSize: 24),
                              ),
                            ],
                          )
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 40),
                          child: Column(
                              children: <Widget>[
                                for(var grade in grades) GradeCard(grade: grade)
                              ]
                          )
                      )
                    ],
                  );
                },
                loading: () => const LoadingView()
            );
          }
      ),
    );
  }
}