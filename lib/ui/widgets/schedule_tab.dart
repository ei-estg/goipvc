import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myipvc_budget_flutter/models/myipvc_lesson.dart';
import 'package:myipvc_budget_flutter/providers/schedule_provider.dart';
import 'package:myipvc_budget_flutter/services/date_verification.dart';
import 'package:myipvc_budget_flutter/ui/views/error.dart';
import 'package:myipvc_budget_flutter/ui/views/loading.dart';
import 'package:myipvc_budget_flutter/ui/widgets/lesson_card.dart';

class ScheduleTab<T> extends StatelessWidget {
  const ScheduleTab({super.key,});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child){
        AsyncValue<List<MyIPVCLesson>> schedule = ref.watch(scheduleProvider);

        return Align(
          alignment: Alignment.center,
          child: schedule.when(
            loading: () => const LoadingView(),
            error: (err, stack) => ErrorView(error: "$err"),
            data: (schedule) {
              List<MyIPVCLesson> todaySchedule = [];

              for(var lesson in schedule){
                if(!verifyIfLessonExpired(lesson)){
                  todaySchedule.add(lesson);
                }
              }

              if (todaySchedule.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text("Não existem aulas hoje")],
                  ),
                );
              }

              return Column(
                children: [
                  const ListTile(
                    title: Text(
                        'Hoje:',
                        style: TextStyle(fontSize: 20)
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        for(var lesson in todaySchedule)
                          LessonCard(lesson: lesson)
                      ],
                    ),
                  ),
                ],
              );
            }
          ),
        );
      }
    );
  }
}