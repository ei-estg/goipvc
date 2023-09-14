import 'package:flutter/material.dart';
import 'package:myipvc_budget_flutter/ui/views/grades.dart';
import 'package:myipvc_budget_flutter/ui/views/home.dart';
import 'package:myipvc_budget_flutter/ui/views/menu.dart';
import 'package:myipvc_budget_flutter/ui/views/schedule.dart';
import 'package:myipvc_budget_flutter/ui/widgets/ipvc_logo.dart';

class IndexView extends StatefulWidget {
  const IndexView({super.key});

  @override
  State<IndexView> createState() => _IndexViewState();
}

class _IndexViewState extends State<IndexView> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.fromLTRB(0,20,96.0,0),
            child: SizedBox(
              height: 48,
              child: IpvcLogo(),
            ),
          ),
          actions: const <Widget>[
            Padding(
                padding: EdgeInsets.fromLTRB(0, 15, 10, 0),
                child: IconButton(
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
            )
          ],
        ),
        bottomNavigationBar: NavigationBar(
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
              selectedIcon: Icon(Icons.description),
              icon: Icon(Icons.description_outlined),
              label: 'Avaliações',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.menu),
              icon: Icon(Icons.menu_outlined),
              label: 'Menu',
            ),
          ],
        ),
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: <Widget>[
            const HomeView(),
            const ScheduleView(),
            const GradesView(),
            const MenuView()
          ][currentPageIndex],
        )
    );
  }
}