import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goipvc/models/myipvc/user.dart';
import 'package:goipvc/providers/profile_provider.dart';
import 'package:goipvc/providers/settings_provider.dart';
import 'package:goipvc/ui/floors.dart';
import 'package:goipvc/ui/views/error.dart';
import 'package:goipvc/ui/views/info.dart';
import 'package:photo_view/photo_view.dart';

class SchoolMapView extends ConsumerWidget {
  const SchoolMapView({super.key});

  void _openImage(BuildContext context, String img) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: const Text("Piso")),
          body: PhotoView(
            imageProvider: AssetImage(img),
          ),
        )));
  }

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

    return SingleChildScrollView(
        child: Column(
      children: [
        for (var map in schoolMaps[profile.unidadeOrganica]!)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: GestureDetector(
              onTap: () {
                _openImage(context, map[theme]);
              },
              child: Image.asset(map[theme]),
            ),
          )
      ],
    ));
  }
}
