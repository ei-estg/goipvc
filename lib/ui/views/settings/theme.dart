import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myipvc_budget_flutter/providers/settings_provider.dart';

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
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Selecionar aparência"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownMenu<String>(
                dropdownMenuEntries: const <DropdownMenuEntry<String>>[
                  DropdownMenuEntry<String>(
                      value: "device",
                      label: "Dispositivo",
                  ),
                  DropdownMenuEntry<String>(
                    value: "school",
                    label: "Escola",
                  ),
                  DropdownMenuEntry<String>(
                    value: "normal",
                    label: "Normal",
                  ),
                ],
                initialSelection: ref.read(settingsProvider).theme,
                label: const Text("Cores"),
                onSelected: (String? theme) {
                  ref.read(settingsProvider.notifier).setTheme(theme ?? "normal");
                },
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
              DropdownMenu<String>(
                dropdownMenuEntries: const <DropdownMenuEntry<String>>[
                  DropdownMenuEntry<String>(
                    value: "system",
                    label: "Dispositivo",
                  ),
                  DropdownMenuEntry<String>(
                    value: "light",
                    label: "Claro",
                  ),
                  DropdownMenuEntry<String>(
                    value: "dark",
                    label: "Escuro",
                  ),
                ],
                initialSelection: ref.read(settingsProvider).brightness,
                label: const Text("Luminosidade"),
                onSelected: (String? brightness) {
                  ref.read(settingsProvider.notifier)
                      .setBrightness(brightness ?? "system");
                },
              )
            ],
          ),
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
          title: const Text("Tema"),
          onTap: () {
            _showAppearanceMenu(context, ref);
          },
          trailing: Text((() {
            if(settings.theme == "normal") {
              return "Normal";
            } else if (settings.theme == "device") {
              return "Dispositivo";
            }

            return "Escola";
          })()),
        )
      ],
    );
  }
}