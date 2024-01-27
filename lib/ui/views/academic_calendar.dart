import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goipvc/models/myipvc/calendar.dart';
import 'package:goipvc/providers/calendar_provider.dart';

import 'error.dart';
import 'loading.dart';

class AcademicCalendarView extends ConsumerWidget {
  const AcademicCalendarView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<MyIPVCCalendar> calendar = ref.watch(calendarProvider);

    return Scaffold(
        appBar: AppBar(title: const Text("Calendário académico")),
        body: calendar.when(
            loading: () => const LoadingView(),
            error: (err, stack) => ErrorView(
                  error: "$err",
                  callback: () {
                    calendar = ref.refresh(calendarProvider);
                  },
                ),
            data: (calendar) {
              return ListView(
                children: [
                  _CalendarCard(
                    title: const Text("Períodos"),
                    body: [
                      const Text("Primeiro Semestre:"),
                      Text(calendar.firstSemesterDates),
                      const Text("Segundo Semestre:"),
                      Text(calendar.firstSemesterDates)
                    ],
                  ),
                  _CalendarCard(
                    title: const Text("Paragem Letiva"),
                    body: [
                      const Text("Natal:"),
                      Text(calendar.christmasBreak),
                      const Text("Carnaval:"),
                      Text(calendar.carnivalBreak),
                      const Text("Páscoa:"),
                      Text(calendar.easterBreak),
                      const Text("Semana Académica:"),
                      Text(calendar.academicWeek)
                    ],
                  ),
                  _CalendarCard(
                    title: const Text("Dias comemorativos"),
                    body: [
                      for (var commemorativeDay
                          in calendar.commemorativeDays.entries)
                        Text(
                            "${commemorativeDay.key}: ${commemorativeDay.value}")
                    ],
                  ),
                  _CalendarCard(
                    title: const Text("Período de exames"),
                    body: [
                      const Text("Época normal / recurso"),
                      const Text("1º Semestre"),
                      Text(calendar.firstSemesterExamDates),
                      const Text("2º Semestre"),
                      Text(calendar.secondSemesterExamDates),
                      const Text("Época especial"),
                      Text(calendar.specialSeasonExamDates)
                    ],
                  ),
                  _CalendarCard(
                    title: const Text("Pagamento de propinas"),
                    body: [
                      const Text("Primeira prestação"),
                      Text(calendar.firstFee),
                      const Text("Restantes prestações"),
                      Text(calendar.followingFees),
                    ],
                  ),
                  _CalendarCard(
                    title: const Text("Feriados"),
                    body: [
                      const Text("Primeiro semestre"),
                      for(var holiday in calendar.firstSemesterHolidays)
                        Text(holiday),
                      const Text("Segundo semestre"),
                      for(var holiday in calendar.secondSemesterHolidays)
                        Text(holiday),
                    ],
                  ),
                ],
              );
            }));
  }
}

class _CalendarCard extends StatelessWidget {
  final Text title;
  final List<Widget> body;

  const _CalendarCard({required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2,
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            title: title,
            children: body,
          ),
        ));
  }
}
