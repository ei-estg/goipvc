import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myipvc_budget_flutter/models/myipvc_lesson.dart';
import 'package:myipvc_budget_flutter/models/myipvc_user.dart';
import 'package:myipvc_budget_flutter/providers/profile_provider.dart';
import 'package:myipvc_budget_flutter/providers/schedule_provider.dart';
import 'package:myipvc_budget_flutter/services/date_verification.dart';
import 'package:myipvc_budget_flutter/ui/views/error.dart';
import 'package:myipvc_budget_flutter/ui/views/loading.dart';
import 'package:myipvc_budget_flutter/ui/widgets/lesson_card.dart';
import 'package:myipvc_budget_flutter/ui/widgets/profile_picture.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<MyIPVCUser> profile = ref.watch(profileProvider);
    AsyncValue<List<MyIPVCLesson>> schedule = ref.watch(scheduleProvider);

    return profile.when(
      loading: () => const LoadingView(),
      error: (err, stack) => ErrorView(error: "$err"),
      data: (profile) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(flex: 1, child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Olá,\n${profile.nome.split(" ")[0]}",
                          style: const TextStyle(fontSize: 32),
                          textAlign: TextAlign.center,
                        )
                      ],
                    )
                  ),
                  Expanded(child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [ProfilePicture(
                        imageData: profile.fotografia,
                        size: 100,
                      )],
                    )
                  )
                ],
               )
              ),
              Flexible(flex: 2, child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Card(
                      elevation: 4, // Optional: Add elevation for a shadow effect
                      margin: const EdgeInsets.all(16.0),
                      child: schedule.when(
                        loading: () => const LoadingView(),
                        error: (err, stack) => ErrorView(error: "$err"),
                        data: (schedule) {
                          schedule.removeWhere((lesson) =>
                            verifyIfLessonExpired(lesson));

                          if(schedule.isEmpty){
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
                                    for(var lesson in schedule)
                                      LessonCard(lesson: lesson)
                                  ],
                                )
                              ),
                            ],
                          );
                        }
                      )
                    ),
                  ),
                ],
              ))
            ],
          )
        );
      }
    );
  }
}