import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myipvc_budget_flutter/services/get_status_from_color.dart';

import '../../models/calendar_meeting.dart';

class LessonDetails extends StatelessWidget {
  final Meeting details;

  const LessonDetails({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(details.fullName),
      content: Text(
        "Prof.: ${details.teacher}\n"
        "Sala: ${details.room}\n"
        "Estado: ${getStatusFromColor(details.originalColor)}"
      ),
    );
  }
}