import 'package:flutter/material.dart';
import 'package:myipvc_budget_flutter/models/myipvc_grade.dart';

class GradeCard<T> extends StatelessWidget {
  final MyIPVCGrade grade;

  const GradeCard({
    super.key,
    required this.grade,

  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Card(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: ListTile(
                title: Text(grade.disciplina, overflow: TextOverflow.ellipsis,),
                subtitle: Text(
                    "${grade.duracao}\n"
                    "${grade.epocaAvaliacao}\n"
                    "Data de avaliação: ${grade.dataAvaliacao}"
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                            value: (double.parse(grade.nota)/20),
                          ),
                        ),
                      ),
                      Center(child: Text(grade.nota))
                    ],
                  ),
                )
            )
          ],
        ),
      )
    );
  }
}