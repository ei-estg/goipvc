import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myipvc_budget_flutter/models/myipvc_grade.dart';
import 'package:myipvc_budget_flutter/providers/final_grade_provider.dart';
import 'package:myipvc_budget_flutter/providers/grades_provider.dart';
import 'package:myipvc_budget_flutter/ui/views/error.dart';
import 'package:myipvc_budget_flutter/ui/views/loading.dart';

import '../widgets/grade_card.dart';

class GradesView extends ConsumerWidget {
  const GradesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<MyIPVCGrade>> grades = ref.watch(gradesProvider);
    AsyncValue<double> finalGrade = ref.watch(finalGradeProvider);

    return grades.when(
      loading: () => const LoadingView(),
      error: (err, stack) => ErrorView(error: "$err"),
      data: (grades) {
        return finalGrade.when(
            error: (err, stack) => ErrorView(error: "$err"),
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
    );


    /*return FutureBuilder(
      future: Future.wait([grades, finalGrade]),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if(snapshot.hasData) {
          return ListView(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Column(
                    children: <Widget>[
                      const Text("Média global", style: TextStyle(fontSize: 32)),
                      const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 8)),
                      Text(
                        snapshot.data![1].toStringAsPrecision(4),
                        style: const TextStyle(fontSize: 24),
                      ),
                    ],
                  )
              ),
              for(var grade in snapshot.data![0]) GradeCard(grade: grade)
            ],
          );
        } else if (snapshot.hasError) {
          return ErrorView(error: "${snapshot.error}");
        }

        return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[CircularProgressIndicator()],
            )
        );
      },
    );*/
  }

}