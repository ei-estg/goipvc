import 'package:flutter/material.dart';
import 'package:goipvc/models/myipvc/grade.dart';

class GradeCard<T> extends StatelessWidget {
  final MyIPVCGrade grade;

  const GradeCard({
    super.key,
    required this.grade,

  });

  @override
  Widget build(BuildContext context) {
    String epocaAvaliacao = grade.epocaAvaliacao;

    if (epocaAvaliacao.contains("Avaliação por ")) {
      epocaAvaliacao = epocaAvaliacao.replaceFirst("Avaliação por ", "");
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
      child: Card(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: ListTile(
                title:
                  Text(
                    grade.disciplina,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                subtitle: Text(
                    "${grade.duracao}\n"
                    "$epocaAvaliacao: ${grade.dataAvaliacao}"
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
                            color: Theme.of(context).colorScheme.primaryContainer,
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            value: 1.0 - (double.parse(grade.nota)/20),
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