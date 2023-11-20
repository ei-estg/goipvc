import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goipvc/providers/device_info_provider.dart';
import 'package:goipvc/providers/settings_provider.dart';

class ThemeSettings<T> extends ConsumerWidget {
  const ThemeSettings({super.key});
  static List<DropdownMenuItem<String>> colorSchemes = [
    const DropdownMenuItem<String>(
      value: "system",
      child: Text("Dispositivo"),
    ),
    const DropdownMenuItem<String>(
      value: "school",
      child: Text("Escola"),
    ),
    const DropdownMenuItem<String>(
      value: "normal",
      child: Text("Normal"),
    ),
  ];
  static List<DropdownMenuItem<String>> themes = [
    const DropdownMenuItem<String>(
      value: "system",
      child: Text("Dispositivo"),
    ),
    const DropdownMenuItem<String>(
      value: "light",
      child: Text("Claro"),
    ),
    const DropdownMenuItem<String>(
      value: "dark",
      child: Text("Escuro"),
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AndroidDeviceInfo? androidDeviceInfo = ref.watch(androidDeviceInfoProvider);
    var settings = ref.watch(settingsProvider);

    // Check if it's android and version 12 or above
    // if not disable material you option
    if(androidDeviceInfo == null || androidDeviceInfo.version.sdkInt < 31) {
      if(colorSchemes.length > 2) {
        colorSchemes.removeAt(0);
      }
    }

    return Wrap(
      children: <Widget>[
        ListTile(
          leading: const Icon(Icons.palette),
          title: const Text("Esquema de Cores"),
          trailing: DropdownButton(
            value: settings.colorScheme,
            items: colorSchemes,
            onChanged: (String? colorScheme) {
              if(colorScheme != null) {
                ref.read(settingsProvider.notifier)
                    .setColorScheme(colorScheme);
              }
            },
          ),
        ),
        ListTile(
          leading: const Icon(Icons.brightness_medium),
          title: const Text("Tema"),
          trailing: DropdownButton(
            value: settings.theme,
            items: themes,
            onChanged: (String? theme) {
              if(theme != null) {
                ref.read(settingsProvider.notifier)
                    .setTheme(theme);
              }
            },
          ),
        )
      ],
    );
  }
}