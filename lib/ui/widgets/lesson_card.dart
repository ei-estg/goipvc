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

    DateTime start = DateTime.parse(lesson.data_hora_ini);
    var formatter = DateFormat('Hm');

    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(lesson.hor_nome),
        subtitle: Text(lesson.sala),
        trailing: Text(formatter.format(start)),
      ),
    );
  }
}