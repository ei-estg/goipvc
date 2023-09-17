import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/calendar_meeting.dart';

class LessonDetails extends StatelessWidget {
  final Meeting details;

  const LessonDetails({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Detalhes da aula"),
      content: Text(
        "${details.fullName}\n"
        "${details.teacher}\n"
        "${details.room}"
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Fechar'),
        ),
      ],
    );
  }
}