import 'package:flutter/material.dart';

class ComingSoonView extends StatelessWidget {
  const ComingSoonView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.construction, size: 48),
          Text("Brevemente", style: TextStyle(fontSize: 20)),
          Text("Quando os programadores tiverem tempo")
        ],
      ),
    );
  }

}