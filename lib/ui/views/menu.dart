import 'package:flutter/material.dart';
import 'package:myipvc_budget_flutter/services/myipvc_api.dart';
import 'package:myipvc_budget_flutter/ui/views/login.dart';
import 'package:myipvc_budget_flutter/ui/views/settings.dart';
import 'package:myipvc_budget_flutter/ui/widgets/menu_list_tile.dart';

class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        MenuListTile(
            icon: const Icon(Icons.person),
            text: const Text("Perfil"),
            onTap: () {}
        ),
        MenuListTile(
            icon: const Icon(Icons.date_range),
            text: const Text("Calendário académico"),
            onTap: () {}
        ),
        MenuListTile(
            icon: const Icon(Icons.badge),
            text: const Text("Cartão digital"),
            onTap: () {}
        ),
        MenuListTile(
            icon: const Icon(Icons.calendar_today),
            text: const Text("Exames"),
            onTap: () {}
        ),
        MenuListTile(
            icon: const Icon(Icons.school),
            text: const Text("Plano Curricular"),
            onTap: () {}
        ),
        MenuListTile(
            icon: const Icon(Icons.map),
            text: const Text("Plantas"),
            onTap: () {}
        ),
        const Divider(),
        MenuListTile(
          icon: const Icon(Icons.settings),
          text: const Text("Definições"),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsView())
            );
          }
        ),
        MenuListTile(
            icon: const Icon(Icons.logout),
            text: const Text("Terminar sessão"),
            onTap: () {
              MyIPVCAPI().logout();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginView())
              );
            }
        )
      ],
    );
  }

}