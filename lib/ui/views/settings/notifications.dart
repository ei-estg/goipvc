import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goipvc/providers/settings_provider.dart';

class _PopUpNotifier extends StateNotifier<bool> {
  _PopUpNotifier() : super(false);

  void set(bool val) {
    state = val;
  }
}

final _popUpProvider = StateNotifierProvider<_PopUpNotifier, bool>(
        (ref) => _PopUpNotifier()
);

class NotificationsSettings<T> extends ConsumerWidget {
  const NotificationsSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(_popUpProvider);
    ref.watch(settingsProvider);

    return Wrap(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 2, 0, 2),
          child: Builder(
            builder: (BuildContext context) {
              return Text(
                "Notificações",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Theme.of(context).colorScheme.primary,
                ),
              );
            },
          ),
        ),
        ListTile(
          title: const Text("Alertas de aula"),
          trailing: DropdownButton(
            value: ref.read(settingsProvider.notifier).getLessonAlert(),
            items: [0,5,10,15,30,60].map<DropdownMenuItem<int>>((int value) {
              return DropdownMenuItem<int>(
                value: value,
                child: Text(value == 0
                  ? "Desativado"
                  : SettingsNotifier.getLessonAlertString(value)
                )
              );
            }).toList(),
            onChanged: (int? time) {
              ref.read(settingsProvider.notifier).setLessonAlert(time ?? 0);
            },
          ),
        )
      ],
    );
  }
}