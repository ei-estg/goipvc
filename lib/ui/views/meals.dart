import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goipvc/providers/meals_provider.dart';
import 'package:goipvc/ui/widgets/meals_list.dart';

import '../../models/meals.dart';

class MealsView extends ConsumerWidget {
  const MealsView({super.key});

  Future<DateTime?> _selectDate(BuildContext context, DateTime selectedDate) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 7))
    );
    if (picked != null && picked != selectedDate) {
      return picked;
    }
    return null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<Meals> meals = ref.watch(mealsProvider);

    return WillPopScope(
        onWillPop: () async {
          ref.read(mealsProvider.notifier).fetchMeals(DateTime.now());
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Ementas"),
            actions: [
              IconButton(
                  onPressed: () async {
                    if(meals.hasValue){
                      final picked = await _selectDate(context, meals.value!.selectedDate);
                      if(picked != null) {
                        ref.read(mealsProvider.notifier).fetchMeals(picked);
                      }
                    }
                  },
                  icon: const Icon(Icons.calendar_month)
              )
            ],
          ),
          body: const MealsList(),
        )
    );
  }
}