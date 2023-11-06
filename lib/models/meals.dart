import 'package:goipvc/models/sas/meal.dart';

class Meals {
  Meals({
    required this.lunch,
    required this.dinner
  });

  List<SASMeal> lunch;
  List<SASMeal> dinner;

  Meals copyWith({List<SASMeal>? lunch, List<SASMeal>? dinner}) {
    return Meals(
        lunch: lunch ?? this.lunch,
        dinner: dinner ?? this.dinner
    );
  }
}