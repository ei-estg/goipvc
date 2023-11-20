import 'package:flutter/material.dart';
import 'package:goipvc/ui/views/firstTime/profilePictureAlignment.dart';
import 'package:goipvc/ui/views/firstTime/theme.dart';
import 'package:goipvc/ui/views/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _pages = <Widget>[
  const FirstTimeThemeSettingsView(),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () { setState(() {
          if(currentPageIndex == _pages.length - 1) {
            setFirstTimeAsSeen(true);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const IndexView()));
          } else {
            currentPageIndex++;
          }
        }); },
        child: const Icon(Icons.navigate_next),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: _pages[currentPageIndex],
      ),
    );
  }
}