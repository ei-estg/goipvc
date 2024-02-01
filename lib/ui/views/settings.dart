import 'package:flutter/material.dart';
import 'package:goipvc/ui/views/settings/profile_picture_alignment.dart';
import 'package:goipvc/ui/views/settings/theme.dart';
import 'package:goipvc/ui/views/settings/notifications.dart';
import 'package:goipvc/ui/widgets/settings_label.dart';

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
        children: const <Widget>[
          SettingsLabel(name: "Aparência"),
          ThemeSettings(),
          Divider(),
          SettingsLabel(name: "Alinhamento da foto"),
          ProfilePictureAlignmentSettings(),
          Divider(),
          SettingsLabel(name: "Notificações"),
          NotificationsSettings()
        ],
      ),
    );
  }
}
