import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrentDate extends StatelessWidget {
  const CurrentDate({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              DateFormat("EEEE", "pt-PT").format(now),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(DateFormat("MMMM yyyy", "pt-PT").format(now))
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            now.day.toString(),
            style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor),
          ),
        )
      ],
    );
  }
}
