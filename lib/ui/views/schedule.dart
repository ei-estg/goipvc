import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
        Color(int.parse(lesson.cor_valor.substring(1), radix: 16) + 0xFF000000),
        false
      ));
    }

    return meetings;
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
            dayFormat: "EEE"
          ),
          firstDayOfWeek: 1,
        );
      }
    );




  }

}