import 'package:flutter/material.dart';

import 'package:goipvc/ui/views/home.dart';
import 'package:goipvc/ui/views/menu.dart';
import 'package:goipvc/ui/views/schedule.dart';
import 'package:goipvc/ui/views/school_map.dart';
import 'package:goipvc/ui/widgets/logo.dart';

class IndexView extends StatefulWidget {
  const IndexView({super.key});

  @override
  State<IndexView> createState() => _IndexViewState();
}

class _IndexViewState extends State<IndexView> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      const HomeView(),
      const ScheduleView(),
      const SchoolMapView(),
      const MenuView()
    ];

    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Logo(),
          actions: const <Widget>[
            IconButton(
                onPressed: null,
                icon: Icon(
                    Icons.notifications_none_outlined,
                    size: 28,
                ),
                // TODO: detect notifications, and use this badge
                /*Badge(
                  child: Icon(Icons.notifications_none_outlined),
                ),*/
            )
          ],
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Divider(height: 0),
            NavigationBar(
              onDestinationSelected: (int index) {
                setState(() {
                  currentPageIndex = index;
                });
              },
              indicatorColor: Theme.of(context).colorScheme.primary,
              selectedIndex: currentPageIndex,
              destinations: const <Widget>[
                NavigationDestination(
                  selectedIcon: Icon(Icons.home),
                  icon: Icon(Icons.home_outlined),
                  label: 'Início',
                ),
                NavigationDestination(
                  selectedIcon: Icon(Icons.today),
                  icon: Icon(Icons.today_outlined),
                  label: 'Horário',
                ),
                NavigationDestination(
                  selectedIcon: Icon(Icons.map),
                  icon: Icon(Icons.map_outlined),
                  label: 'Plantas',
                ),
                NavigationDestination(
                  selectedIcon: Icon(Icons.menu),
                  icon: Icon(Icons.menu_outlined),
                  label: 'Menu',
                ),
              ],
            )
          ],
        ),
        body: WillPopScope(
          onWillPop: () async {
            if(currentPageIndex != 0) {
              setState(() {
                currentPageIndex = 0;
              });
              return false;
            }
            return true;
          },
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: pages[currentPageIndex],
          ),
        )
    );
  }
}