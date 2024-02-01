import 'package:flutter/material.dart';
import 'package:goipvc/ui/views/settings/profile_picture_alignment.dart';

class FirstTimeProfilePictureSettingsView extends StatelessWidget {
  const FirstTimeProfilePictureSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Posicionamento da foto de perfil",
            style: TextStyle(
                fontSize: 24
            ),
          ),
          Text("Podes alterar isto mais tarde nas definições"),
          Padding(padding: EdgeInsets.symmetric(vertical: 8)),
          ProfilePictureAlignmentControls(),
        ],
      ),
    );
  }
}