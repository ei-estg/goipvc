import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goipvc/models/sas/meal.dart';
import 'package:goipvc/providers/quick_meals_provider.dart';
import 'package:goipvc/ui/widgets/meal_card.dart';

import '../views/error.dart';
import '../views/loading.dart';

class MealsTab extends ConsumerWidget {
  const MealsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<List<SASMeal>>> meals = ref.watch(quickMealsProvider);

    return meals.when(
      loading: () => const LoadingView(),
      error: (err, stack) => ErrorView(error: "$err"),
      data: (meals) {
        return Column(
          children: [
            Expanded(
              child: GridView.count(
                childAspectRatio: (0.75),
                crossAxisCount: 2,
                padding: const EdgeInsets.all(4),
                children: [
                  for(var meal in meals[0])
                    MealCard(meal: meal, type: "Almoço"),
                  for(var meal in meals[1])
                    MealCard(meal: meal, type: "Jantar"),
                ],
              ),
            ),
          ],
        );
      }
    );
  }

}