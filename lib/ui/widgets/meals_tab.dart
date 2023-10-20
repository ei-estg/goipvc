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
    AsyncValue<List<List<SASMeal>>> mealsData = ref.watch(quickMealsProvider);
    SharedPreferences prefs = ref.read(sharedPreferencesProvider);
    final deviceWidth = MediaQuery.of(context).size.width;

    if(mealsData.isRefreshing){
      return const LoadingView();
    }

    if(prefs.getString("sas_refresh") == null) {
      return ErrorView(
        error: "Por favor inicie sessão novamente",
        displayError: true,
        callback: () {mealsData = ref.refresh(quickMealsProvider);}
      );
    }

    return mealsData.when(
      loading: () => const LoadingView(),
      error: (err, stack) => ErrorView(
          error: "$err",
          callback: () {mealsData = ref.refresh(quickMealsProvider);}
      ),
      data: (meals) {
        return RefreshIndicator(
            child: Builder(builder: (context) {
              if(meals[0].isEmpty && meals[1].isEmpty){
                return const InfoView(message: "Não existem refeições hoje");
              }

              return ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
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
                              crossAxisCount:
                              MediaQuery.of(context).orientation == Orientation.portrait
                                  ? (deviceWidth / 250).round()
                                  : ((deviceWidth * 0.75) / 250).round(),
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
            }),
            onRefresh: () async {
              return await ref.refresh(quickMealsProvider);
            }
        );




      }
    );
  }

}