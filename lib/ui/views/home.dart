import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myipvc_budget_flutter/models/myipvc_user.dart';
import 'package:myipvc_budget_flutter/providers/profile_provider.dart';
import 'package:myipvc_budget_flutter/ui/views/error.dart';
import 'package:myipvc_budget_flutter/ui/views/loading.dart';
import 'package:myipvc_budget_flutter/ui/widgets/profile_picture.dart';

class HomeView extends ConsumerWidget {
  HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<MyIPVCUser> profile = ref.watch(profileProvider);

    return profile.when(
      loading: () => const LoadingView(),
      error: (err, stack) => ErrorView(error: "$err"),
      data: (profile) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: Row(
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
              const Expanded(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Hoje:"),
                ],
              ))
            ],
          )
        );
      }
    );
  }
}