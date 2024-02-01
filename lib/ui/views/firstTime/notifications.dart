import 'package:flutter/material.dart';
import 'package:goipvc/ui/views/settings/notifications.dart';

class FirstTimeNotificationsView extends StatelessWidget {
  const FirstTimeNotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Notificações",
            style: TextStyle(fontSize: 24),
          ),
          const Text("Podes alterar isto mais tarde nas definições"),
          const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
          const NotificationsSettings(),
          Padding(
            padding: const EdgeInsets.fromLTRB(16,8,16,0),
            child: RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: const <TextSpan>[
                    TextSpan(
                        text: 'Nota: ',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(
                        text:
                            'O sistema de notificações ainda não está completo, pode não funcionar corretamente'),
                  ],
                ),
                textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }
}
