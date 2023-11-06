import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goipvc/models/meals.dart';
import 'package:intl/intl.dart';

import '../services/sas_api.dart';

class MealsNotifier extends StateNotifier<AsyncValue<Meals>> {
  MealsNotifier()
  : super(const AsyncValue.loading()) {
    fetchMeals(DateTime.now());
  }

  Future<void> fetchMeals(DateTime dateTime) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return Meals(
        selectedDate: dateTime,
        lunch: await SAS.getMeals(DateFormat('yyyy-MM-dd').format(dateTime), "lunch"),
        dinner: await SAS.getMeals(DateFormat('yyyy-MM-dd').format(dateTime), "dinner")
      );
    });
  }
}

final mealsProvider = StateNotifierProvider<MealsNotifier, AsyncValue<Meals>>(
  (ref) {return MealsNotifier();},
);