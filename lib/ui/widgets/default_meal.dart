import 'package:flutter/cupertino.dart';

class DefaultMealImage extends StatelessWidget {
  const DefaultMealImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/default_meal.jpeg",
      width: double.infinity,
      height: 100,
      fit: BoxFit.fitWidth,
    );
  }

}