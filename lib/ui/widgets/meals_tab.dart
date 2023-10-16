import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goipvc/models/sas/meal.dart';
import 'package:goipvc/providers/quick_meals_provider.dart';
import 'package:goipvc/ui/views/info.dart';
import 'package:goipvc/ui/widgets/meal_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../providers/shared_preferences_provider.dart';
import '../views/error.dart';
import '../views/loading.dart';

class MealsTab extends ConsumerWidget {
  const MealsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<List<SASMeal>>> meals = ref.watch(quickMealsProvider);
    SharedPreferences prefs = ref.read(sharedPreferencesProvider);
    final deviceWidth = MediaQuery.of(context).size.width;

    if(prefs.getString("sas_refresh") == null) {
      return const ErrorView(
          error: "Por favor inicie sessão novamente"
      );
    }

    return meals.when(
      loading: () => const LoadingView(),
      error: (err, stack) => ErrorView(error: "$err"),
      data: (meals) {
        if(meals[0].isEmpty && meals[1].isEmpty){
          return const InfoView(message: "Não existem refeições hoje");
        }

        return ListView.builder(
          padding: const EdgeInsets.all(4),
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            String title = "";

            if(meals[index].isNotEmpty){
              title = index == 0 ? "Almoço" : "Jantar";
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: (deviceWidth / 225).round(),
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                    childAspectRatio: 0.75
                  ),
                  itemCount: meals[index].length,
                  itemBuilder: (BuildContext context, int mealIndex) {
                    return MealCard(meal: meals[index][mealIndex]);
                  }
                )
              ],
            );
          }
        );
      }
    );
  }

}