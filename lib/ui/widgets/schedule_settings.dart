import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goipvc/providers/settings_provider.dart';

class ScheduleSettings extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var settings = ref.watch(settingsProvider);

    return AlertDialog(
      title: const Text("Preferências"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SwitchListTile(
            title: const Text("Fim de semana"),
            secondary: const Icon(Icons.date_range),
            value: settings.showWeekend,
            onChanged: (value) {
              ref.read(settingsProvider.notifier).setShowWeekend(value);
            }
          )
        ],
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