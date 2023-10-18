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
            backgroundDecoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface
            ),
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
    final deviceWidth = MediaQuery.of(context).size.width;

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

    return GridView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: (deviceWidth / 500).round(),
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
            childAspectRatio: 1.57
        ),
        itemCount: schoolMaps[profile.unidadeOrganica]!.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              _openImage(context, schoolMaps[profile.unidadeOrganica]![index][theme]);
            },
            child: Image.asset(schoolMaps[profile.unidadeOrganica]![index][theme]),
          );
        }
    );
  }
}
