import 'package:flutter/material.dart';
import 'package:goipvc/ui/views/settings/theme.dart';

class FirstTimeThemeSettingsView extends StatelessWidget {
  const FirstTimeThemeSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Customiza a tua app",
            style: TextStyle(
              fontSize: 24
            ),
          ),
          Text("Podes alterar isto mais tarde nas definições"),
          Padding(padding: EdgeInsets.symmetric(vertical: 8)),
          ThemeSettings(),
        ],
      ),
    );
  }
}