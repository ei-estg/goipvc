import 'package:flutter/material.dart';

import '../../services/sas_api.dart';

class MealsView extends StatefulWidget {
  const MealsView({super.key});

  @override
  State<MealsView> createState() => _MealsViewState();
}

class _MealsViewState extends State<MealsView> {
  void test() async {await SAS.fetchAccessToken();}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(onPressed: test, child: Text('click me'))
        ],
      ),
    );
  }
}
