import 'dart:io';

import 'package:flutter/material.dart';

import 'package:goipvc/ui/views/home.dart';
import 'package:goipvc/ui/views/menu.dart';
import 'package:goipvc/ui/views/schedule.dart';
import 'package:goipvc/ui/views/school_map.dart';
import 'package:goipvc/ui/widgets/logo.dart';
import 'package:goipvc/ui/widgets/update_indicator.dart';
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
                launchUrl(Uri.parse("https://github.com/ei-estg/goipvc/releases/latest"));
              },
              child: const Text("Github")
          )
        ],
      ),
      duration: const Duration(seconds: 10),
    ),
  );
}

class IndexView extends StatefulWidget {
  const IndexView({super.key});

  @override
  State<IndexView> createState() => _IndexViewState();
}

class _IndexViewState extends State<IndexView> {
  int currentPageIndex = 0;

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
                        launchUrl(Uri.parse("https://github.com/ei-estg/goipvc/releases/latest"));
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
    final pages = <Widget>[
      const HomeView(),
      const ScheduleView(),
      const SchoolMapView(),
      const MenuView()
    ];

    const destinations = [
      NavigationRailDestination(
        selectedIcon: Icon(Icons.home),
        icon: Icon(Icons.home_outlined),
        label: Text('Início'),
      ),
      NavigationRailDestination(
        selectedIcon: Icon(Icons.today),
        icon: Icon(Icons.today_outlined),
        label: Text('Horário'),
      ),
      NavigationRailDestination(
        selectedIcon: Icon(Icons.map),
        icon: Icon(Icons.map_outlined),
        label: Text('Plantas'),
      ),
      NavigationRailDestination(
        selectedIcon: Icon(Icons.menu),
        icon: Icon(Icons.menu_outlined),
        label: Text('Menu'),
      ),
    ];

    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          surfaceTintColor: Colors.transparent,
          title: const Logo(),
          actions: const <Widget>[
            UpdateIndicator()
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
                      currentPageIndex = index;
                    });
                  },
                  indicatorColor: Theme.of(context).colorScheme.primary,
                  selectedIndex: currentPageIndex,
                  destinations: destinations.map((destination) {
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
                    currentPageIndex = index;
                  });
                },
                labelType: NavigationRailLabelType.all,
                indicatorColor: Theme.of(context).colorScheme.primary,
                selectedIndex: currentPageIndex,
                destinations: destinations,
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
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  child: pages[currentPageIndex],
                ),
              ),
            ),
          ],
        ),
    );
  }
}