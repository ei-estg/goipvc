import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class IpvcLogo<T> extends StatelessWidget {
  const IpvcLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // https://stackoverflow.com/a/56307575
    var brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    final Image logo = Image.asset('assets/ipvc.png');

    // https://stackoverflow.com/a/75045907
    return ColorFiltered(
      colorFilter: isDarkMode
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
            ]),
      child: logo,
    );
  }
}