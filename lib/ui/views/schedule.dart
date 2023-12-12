import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goipvc/providers/settings_provider.dart';
import 'package:goipvc/ui/widgets/lesson_details.dart';
import 'package:goipvc/ui/widgets/schedule_settings.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../models/calendar_meeting.dart';
import '../../models/myipvc/lesson.dart';
import '../../providers/schedule_provider.dart';
import 'error.dart';
import 'loading.dart';

class ScheduleView extends ConsumerWidget {
  const ScheduleView({super.key});

  List<Meeting> _getDataSource(List<MyIPVCLesson> schedule) {
    final List<Meeting> meetings = <Meeting>[];

    for (var lesson in schedule) {
      meetings.add(Meeting(
          "${lesson.sigla}\n${lesson.sala}",
          DateTime.parse(lesson.dataHoraIni),
          DateTime.parse(lesson.dataHoraFim),
          lesson.horNome,
          lesson.nomesDocentes,
          lesson.sala,
          lesson.horNomeTurno,
          lesson.corValor,
          Color(
              int.parse(lesson.corValor.substring(1), radix: 16) + 0xFF000000),
          false));
    }

    return meetings;
  }

  void _showPopup(BuildContext context, Meeting details) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return LessonDetails(details: details);
        });
  }

  void _showScheduleSettings(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ScheduleSettings();
        });
  }
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<MyIPVCLesson>> schedule = ref.watch(scheduleProvider);
    var settings = ref.watch(settingsProvider);

    if(schedule.isRefreshing){
      return const LoadingView();
    }

    return schedule.when(
        loading: () => const LoadingView(),
        error: (err, stack) => ErrorView(
          error: "$err",
          callback: () {schedule = ref.refresh(scheduleProvider);},
        ),
        data: (schedule) {
          return Stack(
            children: [
              SfCalendar(
                key: ValueKey(DateTime.now()),
                view: settings.showWeekend
                  ? CalendarView.week
                  : CalendarView.workWeek,
                dataSource: MeetingDataSource(_getDataSource(schedule)),
                timeSlotViewSettings: const TimeSlotViewSettings(
                    timeFormat: 'H:mm',
                    dayFormat: "EEE",
                    startHour: 7,
                    endHour: 24),
                firstDayOfWeek: 1,
                cellEndPadding: 0,
                selectionDecoration: const BoxDecoration(
                  color: Colors.transparent, // Set the border color to transparent
                ),
                onTap: (CalendarTapDetails tap) {
                  if (tap.targetElement == CalendarElement.appointment) {
                    _showPopup(context, tap.appointments![0]);
                  }
                },
              ),
              Positioned(
                right: 1,
                top: -5,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.refresh),
                      onPressed: () {return ref.refresh(scheduleProvider);},
                    ),
                    IconButton(
                      icon: const Icon(Icons.settings),
                      onPressed: () {_showScheduleSettings(context);},
                    ),
                  ],
                )
              )
            ],
          );
        });
  }
}
