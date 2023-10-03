import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goipvc/providers/deviceInfoProvider.dart';
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

class ThemeSettings<T> extends ConsumerWidget {
  const ThemeSettings({super.key});

  void _showAppearanceMenu(BuildContext context, WidgetRef ref) {
    AndroidDeviceInfo androidDeviceInfo = ref.watch(androidDeviceInfoProvider);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Esquema de Cores"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Check if it's android and version 12 or above
              // if not disable material you option
              if(Platform.isAndroid && androidDeviceInfo.version.sdkInt >= 31)
                RadioListTile<String>(
                  title: const Text("Dispositivo"),
                  value: "system",
                  groupValue: ref.read(settingsProvider).colorScheme,
                  onChanged: (String? colorScheme) {
                    ref.read(settingsProvider.notifier)
                        .setColorScheme("system");
                  },
                ),
              RadioListTile<String>(
                title: const Text("Escola"),
                value: "school",
                groupValue: ref.read(settingsProvider).colorScheme,
                onChanged: (String? colorScheme) {
                  ref.read(settingsProvider.notifier)
                      .setColorScheme("school");
                },
              ),
              RadioListTile<String>(
                title: const Text("Normal"),
                value: "normal",
                groupValue: ref.read(settingsProvider).colorScheme,
                onChanged: (String? colorScheme) {
                  ref.read(settingsProvider.notifier)
                      .setColorScheme("normal");
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showThemeMenu(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Tema"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                title: const Text("Dispositivo"),
                value: "system",
                groupValue: ref.read(settingsProvider).theme,
                onChanged: (String? theme) {
                  ref.read(settingsProvider.notifier)
                      .setTheme("system");
                },
              ),
              RadioListTile<String>(
                title: const Text("Claro"),
                value: "light",
                groupValue: ref.read(settingsProvider).theme,
                onChanged: (String? theme) {
                  ref.read(settingsProvider.notifier)
                      .setTheme("light");
                },
              ),
              RadioListTile<String>(
                title: const Text("Escuro"),
                value: "dark",
                groupValue: ref.read(settingsProvider).theme,
                onChanged: (String? theme) {
                  ref.read(settingsProvider.notifier)
                      .setTheme("dark");
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var settings = ref.watch(settingsProvider);
    ref.watch(_popUpProvider);

    return Wrap(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 2, 0, 2),
          child: Builder(
            builder: (BuildContext context) {
              return Text(
                "Aparência",
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
          title: const Text("Esquema de Cores"),
          onTap: () {
            _showAppearanceMenu(context, ref);
          },
          trailing: Text((() {
            if(settings.colorScheme == "normal") {
              return "Normal";
            } else if (settings.colorScheme == "system") {
              return "Dispositivo";
            }

            return "Escola";
          })()),
        ),
        ListTile(
          title: const Text("Tema"),
          onTap: () {
            _showThemeMenu(context, ref);
          },
          trailing: Text((() {
            if(settings.theme == "light") {
              return "Claro";
            } else if (settings.theme == "dark") {
              return "Escuro";
            }

            return "Dispositivo";
          })()),
        )
      ],
    );
  }
}