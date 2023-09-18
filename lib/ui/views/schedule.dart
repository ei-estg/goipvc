import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myipvc_budget_flutter/ui/widgets/lesson_details.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../models/calendar_meeting.dart';
import '../../models/myipvc_lesson.dart';
import '../../providers/schedule_provider.dart';
import 'error.dart';
import 'loading.dart';

class ScheduleView extends ConsumerWidget {
  const ScheduleView({super.key});

  List<Meeting> _getDataSource(List<MyIPVCLesson> schedule) {
    final List<Meeting> meetings = <Meeting>[];

    for(var lesson in schedule) {
      meetings.add(Meeting(
        "${lesson.sigla}\n${lesson.sala}",
        DateTime.parse(lesson.data_hora_ini),
        DateTime.parse(lesson.data_hora_fim),
        lesson.hor_nome,
        lesson.nomesDocentes,
        lesson.sala,
        lesson.cor_valor,
        Color(int.parse(lesson.cor_valor.substring(1), radix: 16) + 0xFF000000),
        false
      ));
    }

    return meetings;
  }

  void _showPopup(BuildContext context, Meeting details) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return LessonDetails(details: details);
        }
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<MyIPVCLesson>> schedule = ref.watch(scheduleProvider);

    return schedule.when(
      loading: () => const LoadingView(),
      error: (err, stack) => ErrorView(error: "$err"),
      data: (schedule) {
        return SfCalendar(
          view: CalendarView.week,
          dataSource: MeetingDataSource(_getDataSource(schedule)),
          timeSlotViewSettings: const TimeSlotViewSettings(
            timeFormat: 'H:mm',
            dayFormat: "EEE",
            startHour: 7,
            endHour: 24
          ),
          firstDayOfWeek: 1,
          selectionDecoration: const BoxDecoration(
            color: Colors.transparent, // Set the border color to transparent
          ),
          onTap: (CalendarTapDetails tap) {
            if(tap.targetElement == CalendarElement.appointment) {
              _showPopup(context,tap.appointments![0]);
            }
          },
        );
      }
    );




  }

}