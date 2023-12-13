import 'package:flutter/material.dart';

import '../../services/myipvc_api.dart';
import '../views/login.dart';

class LogoutPrompt extends StatelessWidget {
  const LogoutPrompt({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(Icons.logout),
      title: const Text("Terminar sessão?"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Não'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            MyIPVCAPI.logout();
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginView())
            );
          },
          child: const Text('Sim'),
        ),
      ],
    );
  }

}