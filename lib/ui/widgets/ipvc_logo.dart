import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myipvc_budget_flutter/providers/settings_provider.dart';

class IpvcLogo<T> extends ConsumerWidget {
  IpvcLogo({super.key});

  final darkModeFilter = <double>[
    -1.0, 0.0, 0.0, 0.0, 255.0,
    0.0, -1.0, 0.0, 0.0, 255.0,
    0.0, 0.0, -1.0, 0.0, 255.0,
    0.0, 0.0, 0.0, 1.0, 0.0,
  ];

  final lightModeFilter = <double>[
    1.0, 0.0, 0.0, 0.0, 0.0,
    0.0, 1.0, 0.0, 0.0, 0.0,
    0.0, 0.0, 1.0, 0.0, 0.0,
    0.0, 0.0, 0.0, 1.0, 0.0,
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var settings = ref.watch(settingsProvider);
    var systemTheme = SchedulerBinding.instance.platformDispatcher.platformBrightness;

    // Adapted from https://stackoverflow.com/a/56307575

    final Image logo = Image.asset('assets/ipvc.png');

    // https://stackoverflow.com/a/75045907
    return ColorFiltered(
      colorFilter: ColorFilter.matrix((() {
        if(settings.theme == "dark") {
          return darkModeFilter;
        } else if (settings.theme == "light") {
          return lightModeFilter;
        } else {
          if(systemTheme == Brightness.dark) {
            return darkModeFilter;
          } else {
            return lightModeFilter;
          }
        }
      })()),
      child: logo,
    );
  }
}