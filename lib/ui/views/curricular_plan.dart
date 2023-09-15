import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myipvc_budget_flutter/models/myipvc_curricular_unit.dart';
import 'package:myipvc_budget_flutter/providers/curricular_plan_provider.dart';
import 'package:myipvc_budget_flutter/ui/widgets/curricular_unit_button.dart';

import 'error.dart';
import 'loading.dart';

class CurricularPlanView extends ConsumerWidget {
  const CurricularPlanView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<MyIPVCCurricularUnit>> curricularPlan
      = ref.watch(curricularPlanProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Plano curricular"),
      ),
      body: curricularPlan.when(
        loading: () => const LoadingView(),
        error: (err, stack) => ErrorView(error: "$err"),
        data: (curricularPlan) {
          List<int> years = [];

          for(var curricularUnit in curricularPlan) {
            if(!years.contains(curricularUnit.ano_curricular)){
              years.add(curricularUnit.ano_curricular);
            }
          }

          // Just to be sure
          years.sort();

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView(
              children: [
                for(var year in years) Card(
                    elevation: 2,
                    child: Theme(
                      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        title: Text(
                            "$yearº ano",
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                        ),
                        children: [
                          for(var curricularUnit in curricularPlan)
                            if(curricularUnit.ano_curricular == year)
                              CurricularUnitButton(curricularUnit: curricularUnit)
                        ],
                      ),
                    )
                )
              ],
            ),
          );
        }
      )
    );
  }
}