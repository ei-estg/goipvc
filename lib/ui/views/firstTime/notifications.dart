import 'package:flutter/material.dart';
import 'package:goipvc/ui/views/settings/notifications.dart';

class FirstTimeNotificationsView extends StatelessWidget {
  const FirstTimeNotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Notificações",
            style: TextStyle(fontSize: 24),
          ),
          Text("Podes alterar isto mais tarde nas definições"),
          Padding(padding: EdgeInsets.symmetric(vertical: 2)),
          Text(
              "Nota: O sistema de notificações ainda não está completo, podem não funcionar corretamente",
              textAlign: TextAlign.center),
          Padding(padding: EdgeInsets.symmetric(vertical: 4)),
          NotificationsSettings()
        ],
      ),
    );
  }
}
