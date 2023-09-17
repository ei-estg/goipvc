import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myipvc_budget_flutter/providers/settings_provider.dart';
import 'package:myipvc_budget_flutter/providers/profile_provider.dart';

class Logo<T> extends ConsumerWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var settings = ref.watch(settingsProvider);
    var profile = ref.watch(profileProvider);

    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        Theme.of(context).colorScheme.onPrimaryContainer,
        BlendMode.srcIn,
      ),
      child: SvgPicture.asset(
        (() {
          if (settings.colorScheme == "school" && profile != null) {
            return 'assets/${profile.unidade_organica}-logo.svg';
          }

          return 'assets/ipvc-logo.svg';
        })(), // Change this color to match the parts to be filtered
        height: 36,
      ),
    );
  }
}
