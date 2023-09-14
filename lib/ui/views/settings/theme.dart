import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myipvc_budget_flutter/ui/themes/ipvc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../providers/theme_provider.dart';

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

  void updateThemePreference(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("theme", value);
  }

  void _showAppearanceMenu(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Selecionar aparência"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text("Tema do dispositivo"),
                onTap: () {
                  ref.read(themeProvider.notifier).set("device");
                  updateThemePreference("device");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("Escola"),
                onTap: () {
                  ref.read(themeProvider.notifier).set("school");
                  updateThemePreference("school");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("Normal"),
                onTap: () {
                  ref.read(themeProvider.notifier).set("normal");
                  updateThemePreference("normal");
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var theme = ref.watch(themeProvider);
    bool isSwitched = ref.watch(_popUpProvider);

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
            _showAppearanceMenu(context, ref); // Show the appearance menu
          },
          trailing: Text((() {
            if(theme == IPVCTheme) {
              return "Normal";
            } else if (theme == null) {
              return "Dispositivo";
            }

            return "Escola";
          })()),
        ),
        ListTile(
          title: const Text("Modo noturno"),
          trailing: Switch(
            value: isSwitched,
            onChanged: (bool newValue) {
              ref.read(_popUpProvider.notifier).set(newValue);
            },
          ),
        )
      ],
    );
  }
}