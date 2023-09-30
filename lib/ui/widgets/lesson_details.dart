import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:goipvc/services/get_status_from_color.dart';

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
          const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                      "Turno: ${details.type}",
                      style: const TextStyle(fontSize: 14)
                  ),
                  Text(
                      "Inicio: ${DateFormat("HH:mm").format(details.from)}",
                      style: const TextStyle(fontSize: 14)
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                      "Sala: ${details.room}",
                      style: const TextStyle(fontSize: 14)
                  ),
                  Text(
                      "Fim: ${DateFormat("HH:mm").format(details.to)}",
                      style: const TextStyle(fontSize: 14)
                  ),
                ],
              )
            ],
          ),
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