import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myipvc_budget_flutter/models/myipvc_lesson.dart';
import 'package:myipvc_budget_flutter/models/myipvc_user.dart';
import 'package:myipvc_budget_flutter/providers/profile_provider.dart';
import 'package:myipvc_budget_flutter/providers/schedule_provider.dart';
import 'package:myipvc_budget_flutter/ui/views/error.dart';
import 'package:myipvc_budget_flutter/ui/views/loading.dart';
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
              const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 32)),
              Flexible(flex: 2, child: Column(
                children: <Widget>[
                  const Text("Hoje:", style: TextStyle(fontSize: 24)),
                  Expanded(child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                    ),
                    child: schedule.when(
                        loading: () => const LoadingView(),
                        error: (err, stack) => ErrorView(error: "$err"),
                        data: (schedule) {
                          return Text(schedule[0].hor_nome);
                        }
                    ),
                  ))
                ],
              ))
            ],
          )
        );
      }
    );
  }
}