import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goipvc/models/myipvc/curricular_unit.dart';
import 'package:goipvc/providers/curricular_plan_provider.dart';
import 'package:goipvc/ui/widgets/curricular_unit_button.dart';

import 'error.dart';
import 'loading.dart';

class CurricularPlanView extends ConsumerWidget {
  const CurricularPlanView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<MyIPVCCurricularUnit>> curricularPlan =
        ref.watch(curricularPlanProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text("Plano curricular"),
        ),
        body: curricularPlan.when(
            loading: () => const LoadingView(),
            error: (err, stack) => ErrorView(
              error: "$err",
              callback: () {curricularPlan = ref.refresh(curricularPlanProvider);},
            ),
            data: (curricularPlan) {
              List<int> years = [];

              for (var curricularUnit in curricularPlan) {
                if (!years.contains(curricularUnit.anoCurricular)) {
                  years.add(curricularUnit.anoCurricular);
                }
              }

              // Just to be sure
              years.sort();

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListView(
                  children: [
                    for (var year in years)
                      Card(
                          elevation: 2,
                          child: Theme(
                            data: Theme.of(context)
                                .copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              title: Text("$yearº ano",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              children: [
                                for (var curricularUnit in curricularPlan)
                                  if (curricularUnit.anoCurricular == year)
                                    CurricularUnitButton(
                                        curricularUnit: curricularUnit)
                              ],
                            ),
                          ))
                  ],
                ),
              );
            }));
  }
}
