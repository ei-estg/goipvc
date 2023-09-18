import 'package:flutter/material.dart';
import 'package:myipvc_budget_flutter/ui/views/coming_soon.dart';

class AcademicCalendarView extends StatelessWidget {
  const AcademicCalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calendário académico"),
      ),
      body: const ComingSoonView(),
    );
  }
}