import 'package:flutter/material.dart';
import 'package:goipvc/models/myipvc/exam.dart';

class ExamCard<T> extends StatelessWidget {
  final MyIPVCExam exam;

  const ExamCard({
    super.key,
    required this.exam,
  });

  @override
  Widget build(BuildContext context) {
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
                    exam.uc,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                      "${exam.codigoGruAva}\n"
                      "${exam.dataExame}"
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}