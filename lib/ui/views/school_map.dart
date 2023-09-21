import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goipvc/models/myipvc/user.dart';
import 'package:goipvc/providers/profile_provider.dart';
import 'package:goipvc/ui/floors.dart';
import 'package:goipvc/ui/views/error.dart';
import 'package:goipvc/ui/views/info.dart';
import 'package:photo_view/photo_view.dart';

class SchoolMapView extends ConsumerWidget {
  const SchoolMapView({super.key});

  void _openImage(BuildContext context, String img) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => PhotoView(
        imageProvider: AssetImage(img),
      )
    ));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    MyIPVCUser? profile = ref.watch(profileProvider);

    if(profile == null) return const ErrorView(error: "Erro a obter escola");

    if(schoolMaps[profile.unidade_organica]!.isEmpty){
      return const InfoView(message: "Não existem plantas para a sua escola");
    }

    return ListView(
      children: [
        for(var map in schoolMaps[profile.unidade_organica]!)
          ListTile(
            title: Image.asset(map),
            onTap: () {
              _openImage(context, map);
            },
          )
      ],
    );
  }
}