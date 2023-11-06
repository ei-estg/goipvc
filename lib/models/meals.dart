import 'package:goipvc/models/sas/meal.dart';

class Meals {
  Meals({
    required this.selectedDate,
    required this.lunch,
    required this.dinner
  });

  DateTime selectedDate;
  List<SASMeal> lunch;
  List<SASMeal> dinner;

  Meals copyWith({DateTime? selectedDate, List<SASMeal>? lunch, List<SASMeal>? dinner}) {
    return Meals(
        selectedDate: selectedDate ?? this.selectedDate,
        lunch: lunch ?? this.lunch,
        dinner: dinner ?? this.dinner
    );
  }
}