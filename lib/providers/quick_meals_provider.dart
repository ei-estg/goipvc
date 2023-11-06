import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goipvc/models/meals.dart';
import 'package:intl/intl.dart';

import '../services/sas_api.dart';

final quickMealsProvider = FutureProvider<Meals>((ref) async {
  return Meals(
      lunch: await SAS.getMeals(DateFormat('yyyy-MM-dd').format(DateTime.now()), "lunch"),
      dinner: await SAS.getMeals(DateFormat('yyyy-MM-dd').format(DateTime.now()), "dinner")
  );
});