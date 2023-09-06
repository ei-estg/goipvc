import 'package:flutter/material.dart';
import 'package:myipvc_budget_flutter/models/myipvc_grade.dart';
import 'package:myipvc_budget_flutter/services/myipvc_api.dart';
import 'package:myipvc_budget_flutter/ui/views/error.dart';

import '../widgets/grade_card.dart';

class GradesView extends StatefulWidget {
  const GradesView({super.key});

  @override
  State<GradesView> createState() => _GradesViewState();
}

class _GradesViewState extends State<GradesView> {
  late Future<List<MyIPVCGrade>> grades;
  late Future<double> finalGrade;

  @override
  void initState() {
    super.initState();
    grades = MyIPVCAPI().getGrades();
    finalGrade = MyIPVCAPI().getFinalGrade();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
    );
  }

}