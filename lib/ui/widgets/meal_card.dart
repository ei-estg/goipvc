import 'package:flutter/material.dart';
import 'package:goipvc/models/sas/meal.dart';

class MealCard extends StatelessWidget {
  final SASMeal meal;
  final String type;

  const MealCard({
    super.key,
    required this.meal,
    required this.type
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      elevation: 2,
      child: ListView(
        children: [
          Row(
            children: [
              Expanded(child: Image.network(
                meal.imageUrl,
                width: double.infinity,
                height: 100,
                fit: BoxFit.fitWidth,
                errorBuilder: (_, __, ___) {
                  return Image.asset(
                    "assets/default_meal.jpeg",
                    width: double.infinity,
                    height: 100,
                    fit: BoxFit.fitWidth,
                  );
                },
              ))
            ]
          ),
          Row(
              children: [Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            type,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                            )
                        ),
                        Text(meal.type),
                        Text(meal.name),
                        Text("${meal.price.toString()}€")
                      ]
                  )
              )]
          ),
        ],
      )
    );
  }
}