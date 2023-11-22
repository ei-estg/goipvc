import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:goipvc/services/get_status_from_color.dart';

import '../../models/calendar_meeting.dart';

class LessonDetails extends StatelessWidget {
  final Meeting details;

  const LessonDetails({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    final lessonStart = DateFormat("HH:mm").format(details.from);
    final lessonEnd = DateFormat("HH:mm").format(details.to);

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              details.fullName,
              style: const TextStyle(fontSize: 24),
            ),
            Text(
              "Turno ${details.type}"
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child:  Wrap(
                spacing: 8,
                alignment: WrapAlignment.center,
                children: [
                  Chip(
                    avatar: const Icon(Icons.schedule),
                    backgroundColor: Theme.of(context).dialogBackgroundColor,
                    visualDensity: VisualDensity.compact,
                    label: Text('$lessonStart - $lessonEnd'),
                  ),
                  Chip(
                    avatar: const Icon(Icons.room),
                    visualDensity: VisualDensity.compact,
                    label: Text(details.room)
                  ),
                ],
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Prof(s).: ${details.teacher}"),
                Text("Estado: ${getStatusFromColor(details.originalColor)}")
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [TextButton(
                onPressed: (){Navigator.pop(context);},
                child: const Text("Fechar"),
              )],
            )
          ],
        ),
      ),
    );
  }
}