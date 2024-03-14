import 'package:flutter/material.dart';

class CurrentDate extends StatelessWidget {
  const CurrentDate({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "Quinta-feira",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text("Março 2024")
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            "17",
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
