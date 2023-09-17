import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myipvc_budget_flutter/models/myipvc_lesson.dart';

class LessonCard<T> extends StatelessWidget {
  final MyIPVCLesson lesson;

  const LessonCard({
    super.key,
    required this.lesson,
  });

  @override
  Widget build(BuildContext context) {
    // I am beyond confused
    lesson.data_hora_ini = lesson.data_hora_ini.replaceAll("‐", "-");
    lesson.data_hora_fim = lesson.data_hora_fim.replaceAll("‐", "-");

    DateTime start = DateTime.parse(lesson.data_hora_ini);
    DateTime end = DateTime.parse(lesson.data_hora_fim);
    var formatter = DateFormat('Hm');

    return Card(
      margin: const EdgeInsets.fromLTRB(12, 6, 12, 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lesson.hor_nome,
                          style: const TextStyle(fontSize: 18),
                        ),
                        Text("Docente: ${lesson.nomesDocentes}",
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w300)
                        ),
                        Text("Sala: ${lesson.sala}",
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w300)
                        )
                      ]
                  )
              )
          ),
          Card(
              margin: const EdgeInsets.all(0),
              elevation: 0,
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                child: Column(
                    children: [
                      Text(formatter.format(start)),
                      const Text("|"),
                      Text(formatter.format(end)),
                    ]
                ),
              )
          ),
        ],
      ),
    );
  }
}
