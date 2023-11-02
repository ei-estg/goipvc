import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goipvc/ui/widgets/lesson_details.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../models/calendar_meeting.dart';
import '../../models/myipvc/lesson.dart';
import '../../providers/schedule_provider.dart';
import 'error.dart';
import 'loading.dart';

class ScheduleView extends ConsumerWidget {
  const ScheduleView({super.key});

  List<Meeting> _getDataSource(BuildContext context, List<MyIPVCLesson> schedule) {
    final List<Meeting> meetings = <Meeting>[];
    final List<Map<String, String>> holidays = [
      {
        "date": "2023-11-01",
        "localName": "Dia de Todos-os-Santos"
      },
      {
        "date": "2023-12-01",
        "localName": "Restauração da Independência"
      },
      {
        "date": "2023-12-08",
        "localName": "Imaculada Conceição"
      },
      {
        "date": "2023-12-25",
        "localName": "Natal"
      },
      {
        "date": "2023-12-26",
        "localName": "Primeira Oitava"
      }
    ];

    for (var lesson in schedule) {
      final lessonDate = DateTime.parse(lesson.dataHoraIni).toLocal();
      final lessonDateFormatted = lessonDate.toString().substring(0, 10);

      if (!holidays.any((holiday) => holiday['date'] == lessonDateFormatted)) {
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
                int.parse(lesson.corValor.substring(1), radix: 16) +
                    0xFF000000),
            false));
      }
    }

    for(var holiday in holidays){
      meetings.add(Meeting(
          "${holiday['localName']}",
          DateTime.parse(holiday['date']!),
          DateTime.parse(holiday['date']!),
          "",
          "",
          "",
          "",
          "",
          Theme.of(context).colorScheme.primary,
          true));
    }

    return meetings;
  }

  List<TimeRegion> _getTimeRegions() {
    final List<TimeRegion> regions = <TimeRegion>[];
    final List<Map<String, String>> holidays = [
      {
        "date": "2023-11-01",
        "localName": "Dia de Todos-os-Santos"
      },
      {
        "date": "2023-12-01",
        "localName": "Restauração da Independência"
      },
      {
        "date": "2023-12-08",
        "localName": "Imaculada Conceição"
      },
      {
        "date": "2023-12-25",
        "localName": "Natal"
      }
    ];

    for(var holiday in holidays) {
      regions.add(TimeRegion(
          startTime: DateTime.parse(holiday['date']!),
          endTime: DateTime.parse(holiday['date']!).add(const Duration(hours: 24)),
          enablePointerInteraction: false,
          color: Colors.grey.withOpacity(0.1)));
    }

    return regions;
  }


  void _showPopup(BuildContext context, Meeting details) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return LessonDetails(details: details);
        });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<MyIPVCLesson>> schedule = ref.watch(scheduleProvider);

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
                view: CalendarView.week,
                dataSource: MeetingDataSource(_getDataSource(context, schedule)),
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
                specialRegions: _getTimeRegions(),
              ),
              Positioned(
                right: 1,
                top: -5,
                child: IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {return ref.refresh(scheduleProvider);},
                ),
              )
            ],
          );
        });
  }
}
