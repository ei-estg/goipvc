import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goipvc/models/sas/meal.dart';
import 'package:intl/intl.dart';

import '../services/sas_api.dart';

final quickMealsProvider = FutureProvider<List<List<SASMeal>>>((ref) async {
  return [
    await SAS.getMeals(DateFormat('yyyy-MM-dd').format(DateTime.now()), "lunch"),
    await SAS.getMeals(DateFormat('yyyy-MM-dd').format(DateTime.now()), "dinner")
  ];
});