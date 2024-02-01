import 'package:flutter/material.dart';

class SettingsLabel extends StatelessWidget {
  final String name;

  const SettingsLabel({
    super.key,
    required this.name
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 2, 0, 2),
      child: Builder(
        builder: (BuildContext context) {
          return Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Theme.of(context).colorScheme.primary,
            ),
          );
        },
      ),
    );
  }
}