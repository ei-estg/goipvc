import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:goipvc/models/myipvc/lesson.dart';

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

    // Math for time in class
    double progress = (
        DateTime.now().millisecondsSinceEpoch - start.millisecondsSinceEpoch)
        / (end.millisecondsSinceEpoch - start.millisecondsSinceEpoch
    );

    if(progress <= 0 || progress > 1){
      progress = 0;
    }

    return Card(
      color: Theme.of(context).colorScheme.surface,
      margin: const EdgeInsets.fromLTRB(12, 6, 12, 6),
      elevation: 2,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Padding(
                  padding: const EdgeInsets
                    .symmetric(horizontal: 16),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lesson.hor_nome,
                          style: const TextStyle(fontSize: 18),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text("Docente: ${lesson.nomesDocentes}",
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w300)
                        ),
                        Text("Sala: ${lesson.sala}",
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w300)
                        ),
                        Text("Turno: ${lesson.hor_nome_turno}",
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w300)
                        ),
                      ]
                  )
              )
          ),
          Row(
              children: [
                //progress bar with text inside it
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),

                  //from https://stackoverflow.com/questions/58518161/flutter-text-inside-linearprogressindicator

                  child: Stack(     //Position absolute thing for multiple things inside one another
                    children: [
                      SizedBox(
                        height: 95,
                        width: 80,
                        child: LinearProgressIndicator(
                          value: progress,
                          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).colorScheme.secondary.withAlpha(80)
                          )
                        ),
                      ),
                      SizedBox(
                        height: 95,
                        width: 80,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(formatter.format(start)),
                              const Text("|"),
                              Text(formatter.format(end)),
                            ]
                        ),
                      )
                    ],
                  ),
                )
              ]
          )
        ],
      ),
    );
  }
}
