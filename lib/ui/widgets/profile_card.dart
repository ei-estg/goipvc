import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goipvc/ui/views/error.dart';
import 'package:goipvc/ui/widgets/profile_picture.dart';

import '../../models/myipvc/user.dart';
import '../../providers/profile_provider.dart';
import '../views/profile.dart';

class ProfileCard<T> extends ConsumerWidget {
  const ProfileCard({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    MyIPVCUser? profile = ref.watch(profileProvider);

    if (profile != null) {
      var splitName = profile.nome.split(" ");

      return Card(
          elevation: 2,
          margin: const EdgeInsets.all(16),
          child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfileView()));
              },
              child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Perfil",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                  flex: 8,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ProfilePicture(
                                        imageData: profile.fotografia,
                                        size: 60,
                                      ),
                                      const Padding(padding: EdgeInsets.all(8)),
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              "${splitName[0]} "
                                              "${splitName[splitName.length - 1]}",
                                              overflow: TextOverflow.ellipsis),
                                          Text(
                                              "${profile.siglaCurso} - ${profile.unidadeOrganica}",
                                              style:
                                                  const TextStyle(fontSize: 12),
                                              overflow: TextOverflow.ellipsis),
                                          Text("Nº${profile.numUtilizador}",
                                              style:
                                                  const TextStyle(fontSize: 12),
                                              overflow: TextOverflow.ellipsis)
                                        ],
                                      )),
                                    ],
                                  )),
                              const Flexible(
                                  flex: 1, child: Icon(Icons.arrow_forward))
                            ],
                          ))
                    ],
                  ))));
    } else {
      return const ErrorView(error: "Erro a obter perfil");
    }
  }
}
