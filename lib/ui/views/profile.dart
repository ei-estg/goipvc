import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/myipvc_user.dart';
import '../../providers/profile_provider.dart';
import '../widgets/profile_picture.dart';
import 'error.dart';
import 'loading.dart';

class ProfileView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<MyIPVCUser> profile = ref.watch(profileProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text("Perfil"),
        ),
        body: profile.when(
            loading: () => const LoadingView(),
            error: (err, stack) => ErrorView(error: "$err"),
            data: (profile) {
              return ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ProfilePicture(
                          imageData: profile.fotografia,
                          size: 125,
                        )
                      ],
                    ),
                    const Padding(padding: EdgeInsets.all(8)),
                    Text(
                      profile.nome,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(4)),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.tag),
                      title: Text(
                          "Aluno Nº${profile.num_utilizador}",
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.school),
                      title: Text(
                          "[${profile.id_curso}] ${profile.nm_curso}",
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.apartment),
                      title: Text(
                          profile.unidade_organica,
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.email),
                      title: Text(
                          profile.email,
                      ),
                    ),
                  ],
                );
            }
        )
    );
  }
}