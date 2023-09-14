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
    var systemBrightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;

    // Adapted from https://stackoverflow.com/a/56307575

    final Image logo = Image.asset('assets/ipvc.png');

    // https://stackoverflow.com/a/75045907
    return ColorFiltered(
      colorFilter: ColorFilter.matrix((() {
        if(settings.brightness == "dark") {
          return darkModeFilter;
        } else if (settings.brightness == "light") {
          return lightModeFilter;
        } else {
          if(systemBrightness == Brightness.dark) {
            return darkModeFilter;
          } else {
            return lightModeFilter;
          }
        }
      })()),


      /*theme == ThemeMode.dark
          ? const ColorFilter.matrix(<double>[
              -1.0, 0.0, 0.0, 0.0, 255.0,
              0.0, -1.0, 0.0, 0.0, 255.0,
              0.0, 0.0, -1.0, 0.0, 255.0,
              0.0, 0.0, 0.0, 1.0, 0.0,
            ])
          : const ColorFilter.matrix(<double>[
              1.0, 0.0, 0.0, 0.0, 0.0, //
              0.0, 1.0, 0.0, 0.0, 0.0, //
              0.0, 0.0, 1.0, 0.0, 0.0, //
              0.0, 0.0, 0.0, 1.0, 0.0, //
            ]),*/
      child: logo,
    );
  }
}