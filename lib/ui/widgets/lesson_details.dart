import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myipvc_budget_flutter/services/get_status_from_color.dart';

import '../../models/calendar_meeting.dart';

class LessonDetails extends StatelessWidget {
  final Meeting details;

  const LessonDetails({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(details.fullName, textAlign: TextAlign.center),
          Text("Sala ${details.room}", style: const TextStyle(fontSize: 16)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                  "Inicio: ${DateFormat("HH:mm").format(details.from)}",
                  style: const TextStyle(fontSize: 14)
              ),
              Text(
                  "Fim: ${DateFormat("HH:mm").format(details.to)}",
                  style: const TextStyle(fontSize: 14)
              )
            ],
          )
        ],
      ),
      content: Text(
        "Prof(s).: ${details.teacher}\n"
        "Estado: ${getStatusFromColor(details.originalColor)}"
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Fechar'),
        ),
      ],
    );
  }
}