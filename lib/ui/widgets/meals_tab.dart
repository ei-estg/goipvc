import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goipvc/models/sas/meal.dart';
import 'package:goipvc/providers/quick_meals_provider.dart';

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
        return Text(meals.toString());
      }
    );
  }

}