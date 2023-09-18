import 'package:flutter/material.dart';
import 'package:myipvc_budget_flutter/ui/views/coming_soon.dart';

class ExamsView extends StatelessWidget {
  const ExamsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exames"),
      ),
      body: const ComingSoonView(),
    );
  }
}