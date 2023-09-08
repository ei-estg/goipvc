import 'package:flutter/material.dart';
import 'package:myipvc_budget_flutter/ui/views/settings/theme.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Definições"),
      ),
      body: ListView(
        children: <Widget>[
          ThemeSettings(),
          const Divider(),
        ],
      ),
    );
  }
}
