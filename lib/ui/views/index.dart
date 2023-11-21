import 'dart:io';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:goipvc/ui/animations/shared_axis_switcher.dart';

import 'package:goipvc/ui/views/home.dart';
import 'package:goipvc/ui/views/menu.dart';
import 'package:goipvc/ui/views/schedule.dart';
import 'package:goipvc/ui/views/school_map.dart';
import 'package:goipvc/ui/widgets/logo.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../services/github.dart';

void _errorSnackbar (BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
              "Erro a transferir atualização.\n"
              "Por favor atualize no Github."
          ),
          TextButton(
              onPressed: () {
                launchUrl(Uri.parse("https://github.com/joaoalves03/goipvc/releases/latest"));
              },
              child: const Text("Github")
          )
        ],
      ),
      duration: const Duration(seconds: 10),
    ),
  );
}

final _pages = <Widget>[
  const HomeView(),
  const ScheduleView(),
  const SchoolMapView(),
  const MenuView()
];

final _destinations = [
  const NavigationRailDestination(
    selectedIcon: Icon(Icons.home),
    icon: Icon(Icons.home_outlined),
    label: Text('Início'),
  ),
  const NavigationRailDestination(
    selectedIcon: Icon(Icons.today),
    icon: Icon(Icons.today_outlined),
    label: Text('Horário'),
  ),
  const NavigationRailDestination(
    selectedIcon: Icon(Icons.map),
    icon: Icon(Icons.map_outlined),
    label: Text('Plantas'),
  ),
  const NavigationRailDestination(
    selectedIcon: Icon(Icons.menu),
    icon: Icon(Icons.menu_outlined),
    label: Text('Menu'),
  ),
];

class IndexView extends StatefulWidget {
  const IndexView({super.key});

  @override
  State<IndexView> createState() => _IndexViewState();
}

class _IndexViewState extends State<IndexView> {
  int currentPageIndex = 0;
  bool navigatingRight = true;

  @override
  void initState(){
    super.initState();

    getNewRelease().then((version) => {
      if(version != null){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    "Nova versão disponível: $version",
                ),
                TextButton(
                    onPressed: () {
                      if(Platform.isAndroid){
                        try {
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  "A transferir atualização...\n"
                                  "Após a transferência será pedido para confirmar a instalação."
                              ),
                              // I think this is long enough :)
                              duration: Duration(days: 365),
                            ),
                          );

                          downloadUpdateAndroid().then((error) => {
                            ScaffoldMessenger.of(context).clearSnackBars(),
                            if(error) _errorSnackbar(context)
                          });
                        } catch (error) {
                          _errorSnackbar(context);
                        }
                      } else {
                        launchUrl(Uri.parse("https://github.com/joaoalves03/goipvc/releases/latest"));
                      }
                    },
                    child: Text(
                      "Transferir",
                      style: TextStyle(color: Theme.of(context).colorScheme.surface),
                    )
                )
              ],
            ),
            duration: const Duration(seconds: 5), // Adjust the duration as needed
          ),
        )
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          surfaceTintColor: Colors.transparent,
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
        bottomNavigationBar:
          MediaQuery.of(context).orientation == Orientation.portrait
            ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                NavigationBar(
                  onDestinationSelected: (int index) {
                    setState(() {
                      navigatingRight = index > currentPageIndex;
                      currentPageIndex = index;
                    });
                  },
                  indicatorColor: Theme.of(context).colorScheme.primary,
                  selectedIndex: currentPageIndex,
                  destinations: _destinations.map((destination) {
                    return NavigationDestination(
                        icon: destination.icon,
                        selectedIcon: destination.selectedIcon,
                        label: (destination.label as Text).data!
                    );
                  }).toList()
                )
              ],
            )
            : null,
        body: Row(
          children: [
            if(MediaQuery.of(context).orientation == Orientation.landscape)
              NavigationRail(
                onDestinationSelected: (int index) {
                  setState(() {
                    navigatingRight = index > currentPageIndex;
                    currentPageIndex = index;
                  });
                },
                labelType: NavigationRailLabelType.all,
                indicatorColor: Theme.of(context).colorScheme.primary,
                selectedIndex: currentPageIndex,
                destinations: _destinations,
              ),
            Expanded(
              child: WillPopScope(
                onWillPop: () async {
                  if(currentPageIndex != 0) {
                    setState(() {
                      currentPageIndex = 0;
                    });
                    return false;
                  }
                  return true;
                },
                child: SharedAxisSwitcher(
                  duration: const Duration(milliseconds: 250),
                  type: SharedAxisTransitionType.horizontal,
                  reverse: !navigatingRight,
                  child: _pages[currentPageIndex],
                )
              ),
            ),
          ],
        ),
    );
  }
}