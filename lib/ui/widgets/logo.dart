import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goipvc/providers/settings_provider.dart';
import 'package:goipvc/providers/profile_provider.dart';

class Logo<T> extends ConsumerWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var settings = ref.watch(settingsProvider);
    var profile = ref.watch(profileProvider);
    var systemTheme =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;

    return ColorFiltered(
      colorFilter: settings.theme != "light" || systemTheme == Brightness.light
          ? ColorFilter.mode(
              Theme.of(context).colorScheme.onPrimaryContainer,
              BlendMode.srcIn,
            )
          : const ColorFilter.mode(Colors.transparent, BlendMode.saturation),
      child: SvgPicture.asset(
        (() {
          if (settings.colorScheme == "school" && profile != null) {
            return 'assets/${profile.unidadeOrganica}-logo.svg';
          }

          return 'assets/ipvc-logo.svg';
        })(), // Change this color to match the parts to be filtered
        height: 36,
      ),
    );
  }
}
