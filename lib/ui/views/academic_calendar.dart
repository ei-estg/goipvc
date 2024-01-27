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
                    title: "Períodos",
                    body: [
                      const Text("Primeiro Semestre:",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(calendar.firstSemesterDates),
                      const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
                      const Text("Segundo Semestre:",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(calendar.firstSemesterDates)
                    ],
                  ),
                  _CalendarCard(
                    title: "Paragem letiva",
                    body: [
                      const Text("Natal:",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(calendar.christmasBreak),
                      const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
                      const Text("Carnaval:",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(calendar.carnivalBreak),
                      const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
                      const Text("Páscoa:",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(calendar.easterBreak),
                      const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
                      const Text("Semana Académica:",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(calendar.academicWeek)
                    ],
                  ),
                  _CalendarCard(
                    title: "Dias comemorativos",
                    body: [
                      for (var commemorativeDay
                          in calendar.commemorativeDays.entries)
                        Text.rich(TextSpan(children: [
                          TextSpan(
                              text: "${commemorativeDay.key}: ",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: commemorativeDay.value)
                        ]))
                    ],
                  ),
                  _CalendarCard(
                    title: "Período de exames",
                    body: [
                      const Text("Época normal / recurso",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
                      const Text("1º Semestre",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(calendar.firstSemesterExamDates),
                      const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
                      const Text("2º Semestre",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(calendar.secondSemesterExamDates),
                      const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                      const Text("Época especial",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(calendar.specialSeasonExamDates)
                    ],
                  ),
                  _CalendarCard(
                    title: "Pagamento de propinas",
                    body: [
                      const Text("Primeira prestação:",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(calendar.firstFee),
                      const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
                      const Text("Restantes prestações:",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(calendar.followingFees),
                    ],
                  ),
                  _CalendarCard(
                    title: "Feriados",
                    body: [
                      const Text("Primeiro semestre:",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      for (var holiday in calendar.firstSemesterHolidays)
                        Text(holiday),
                      const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
                      const Text("Segundo semestre:",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      for (var holiday in calendar.secondSemesterHolidays)
                        Text(holiday),
                    ],
                  ),
                ],
              );
            }));
  }
}

class _CalendarCard extends StatelessWidget {
  final String title;
  final List<Widget> body;

  const _CalendarCard({required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
          elevation: 2,
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              title: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: body,
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
