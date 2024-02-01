import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:goipvc/ui/animations/shared_axis_switcher.dart';
import 'package:goipvc/ui/views/firstTime/notifications.dart';
import 'package:goipvc/ui/views/firstTime/profilePictureAlignment.dart';
import 'package:goipvc/ui/views/firstTime/theme.dart';
import 'package:goipvc/ui/views/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _pages = <Widget>[
  const FirstTimeThemeSettingsView(),
  const FirstTimeNotificationsView(),
  const FirstTimeProfilePictureSettingsView()
];

class FirstTimeView extends StatefulWidget {
  const FirstTimeView({super.key});

  @override
  State<FirstTimeView> createState() => _FirstTimeViewState();
}

class _FirstTimeViewState extends State<FirstTimeView> {
  int currentPageIndex = 0;

  Future<void> setFirstTimeAsSeen(bool val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool("hasSeenFirstTimeSetup", val);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Stack(
          children: [
            if (currentPageIndex != 0)
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: FloatingActionButton(
                      heroTag: null,
                      onPressed: () {
                        setState(() {
                          currentPageIndex--;
                        });
                      },
                      child: const Icon(Icons.navigate_before),
                    )),
              ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: FloatingActionButton(
                  heroTag: null,
                  onPressed: () {
                    setState(() {
                      if (currentPageIndex == _pages.length - 1) {
                        setFirstTimeAsSeen(true);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const IndexView()));
                      } else {
                        currentPageIndex++;
                      }
                    });
                  },
                  child: const Icon(Icons.navigate_next),
                ),
              ),
            )
          ],
        ),
        body: SharedAxisSwitcher(
          duration: const Duration(milliseconds: 500),
          type: SharedAxisTransitionType.vertical,
          child: _pages[currentPageIndex],
        ));
  }
}
