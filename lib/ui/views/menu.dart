import 'package:flutter/material.dart';
import 'package:goipvc/services/myipvc_api.dart';
import 'package:goipvc/ui/views/about.dart';
import 'package:goipvc/ui/views/academic_calendar.dart';
import 'package:goipvc/ui/views/curricular_plan.dart';
import 'package:goipvc/ui/views/exams.dart';
import 'package:goipvc/ui/views/grades.dart';
import 'package:goipvc/ui/views/login.dart';
import 'package:goipvc/ui/views/settings.dart';
import 'package:goipvc/ui/widgets/menu_list_tile.dart';
import 'package:goipvc/ui/widgets/profile_card.dart';

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
        const ProfileCard(),
        MenuListTile(
            icon: const Icon(Icons.description),
            text: const Text("Avaliações"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GradesView())
              );
            }
        ),
        MenuListTile(
            icon: const Icon(Icons.school),
            text: const Text("Plano curricular"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CurricularPlanView())
              );
            }
        ),
        MenuListTile(
            icon: const Icon(Icons.calendar_today),
            text: const Text("Exames"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ExamsView())
              );
            }
        ),
        MenuListTile(
            icon: const Icon(Icons.date_range),
            text: const Text("Calendário académico"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AcademicCalendarView())
              );
            }
        ),
        const Divider(),
        MenuListTile(
            icon: const Icon(Icons.info),
            text: const Text("Sobre"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutView())
              );
            }
        ),
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
                  MaterialPageRoute(builder: (context) => LoginView())
              );
            }
        )
      ],
    );
  }

}