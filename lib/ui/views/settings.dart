import 'package:flutter/material.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool isSwitched = false;
  String selectedAppearanceOption = 'Use Device';

  void _showAppearanceMenu(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Appearance"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text("Use Device"),
                onTap: () {
                  setState(() {
                    selectedAppearanceOption = 'Use Device';
                  });
                  Navigator.pop(context); // Close the dialog
                },
              ),
              ListTile(
                title: const Text("Light"),
                onTap: () {
                  setState(() {
                    selectedAppearanceOption = 'Light';
                  });
                  Navigator.pop(context); // Close the dialog
                },
              ),
              ListTile(
                title: const Text("Dark"),
                onTap: () {
                  setState(() {
                    selectedAppearanceOption = 'Dark';
                  });
                  Navigator.pop(context); // Close the dialog
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Definições"),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 2, 0, 2),
            child: Builder(
              builder: (BuildContext context) {
                return Text(
                  "Aparencia ",
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
              _showAppearanceMenu(context); // Show the appearance menu
            },
            trailing: Text(selectedAppearanceOption),
          ),
          ListTile(
            title: const Text("Material You"),
            trailing: Switch(
              value: isSwitched,
              onChanged: (bool newValue) {
                setState(() {
                  isSwitched = newValue; // Update the switch state
                  // Handle any action you want when the switch is toggled
                });
              },
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
