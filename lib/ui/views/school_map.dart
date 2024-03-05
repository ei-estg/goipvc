import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goipvc/models/myipvc/user.dart';
import 'package:goipvc/providers/profile_provider.dart';
import 'package:goipvc/providers/settings_provider.dart';
import 'package:goipvc/ui/floors.dart';
import 'package:goipvc/ui/views/error.dart';
import 'package:goipvc/ui/views/info.dart';
import 'package:goipvc/ui/widgets/floor_selector.dart';

class SchoolMapView extends ConsumerWidget {
  const SchoolMapView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    MyIPVCUser? profile = ref.watch(profileProvider);
    final settings = ref.watch(settingsProvider);
    final systemTheme =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    var theme = "";

    if (settings.theme == "system") {
      if (systemTheme == Brightness.dark) {
        theme = "dark";
      } else {
        theme = "light";
      }
    } else {
      theme = settings.theme;
    }

    if (profile == null) return const ErrorView(error: "Erro a obter escola");

    if (schoolMaps[profile.unidadeOrganica]!.isEmpty) {
      return const InfoView(message: "Não existem plantas para a sua escola");
    }

    return FloorSelector(profile: profile, theme: theme);
  }
}
