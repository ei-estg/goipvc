import 'package:flutter/material.dart';
import 'package:goipvc/models/sas/meal.dart';

class MealCard extends StatelessWidget {
  final SASMeal meal;

  const MealCard({
    super.key,
    required this.meal
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      elevation: 2,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
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
                  children: [
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  meal.type,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16
                                  )
                              ),
                              Text(
                                  meal.name,
                                  style: const TextStyle(
                                      fontSize: 16
                                  )
                              )
                            ],
                          ),
                        )
                    )
                  ]
              ),
            ],
          ),
          Container(
            width: double.infinity, // Set the width to use all horizontal space
            height: 30,
            color: Theme.of(context).colorScheme.secondaryContainer,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "${meal.price.toString()}€",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                )
              ),
            )
          )
        ],
      )
    );
  }
}