import 'package:flutter/material.dart';
import 'package:goipvc/ui/widgets/schedule_tab.dart';

import 'meals_list.dart';

class HomeViewTabs extends StatelessWidget {
  final TabController tabController;

  const HomeViewTabs({
    super.key,
    required this.tabController
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Padding(
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 0),
            child: Text("Hoje", style: TextStyle(fontSize: 20))
        ),
        TabBar(
          controller: tabController,
          tabs: const <Tab>[
            Tab(
              text: "Aulas",
              icon: Icon(Icons.schedule),
            ),
            Tab(
              text: "Ementas",
              icon: Icon(Icons.restaurant_menu),
            )
          ],
        ),
        Expanded(
            flex: 1,
            child: TabBarView(
              controller: tabController,
              children: const <Widget>[
                ScheduleTab(),
                MealsList()
              ],
            )
        )
      ],
    );
  }

}