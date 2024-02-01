import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:goipvc/models/myipvc/exam.dart';
import 'package:intl/intl.dart';

class ExamCard<T> extends StatelessWidget {
  final MyIPVCExam exam;

  const ExamCard({
    super.key,
    required this.exam,
  });

  static final _examCodeMap = HashMap.from({
    "3": "Exame Recurso",
    "4": "Melhoria",
    "20": "Exame Especial / Trab. Estudante",
    "21": "Exame Especial / Finalista"
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
                  title: Text(
                    exam.uc,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                      "${_examCodeMap[exam.codigoGruAva] ?? "Tipo de exame desconhecido"}\n"
                      "${DateFormat("dd-MM-yyyy HH:mm").format(DateTime.parse(exam.dataExame))}"),
                ),
              ),
            ],
          ),
        ));
  }
}
