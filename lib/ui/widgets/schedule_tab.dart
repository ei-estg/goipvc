import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goipvc/models/myipvc/lesson.dart';
import 'package:goipvc/providers/schedule_provider.dart';
import 'package:goipvc/services/date_verification.dart';
import 'package:goipvc/ui/views/error.dart';
import 'package:goipvc/ui/views/loading.dart';
import 'package:goipvc/ui/widgets/lesson_card.dart';

final _refreshProvider = StreamProvider<void>((ref) {
  return Stream.periodic(const Duration(seconds: 60), (count) => count);
});

class ScheduleTab<T> extends StatelessWidget {
  const ScheduleTab({super.key,});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child){
        AsyncValue<List<MyIPVCLesson>> schedule = ref.watch(scheduleProvider);
        ref.watch(_refreshProvider);

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