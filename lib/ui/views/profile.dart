import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_svg/flutter_svg.dart';
import '../../models/myipvc_user.dart';
import '../../providers/profile_provider.dart';
import '../widgets/profile_picture.dart';
import 'error.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    MyIPVCUser? profile = ref.watch(profileProvider);

    // Define a GlobalKey to access the scaffold state for showing the bottom sheet.
    final scaffoldKey = GlobalKey<ScaffoldState>();

    void showBottomSheet() {
      scaffoldKey.currentState?.showBottomSheet(
        (context) => Container(
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                  child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset(
                                'assets/ipvc-logo.svg',
                                height: 30,
                              ),
                              ProfilePicture(
                                imageData: profile?.fotografia,
                                size: 80,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Cartão",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "De Aluno",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "Student Card",
                                        style: TextStyle(
                                          fontSize: 8,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),

                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        profile?.nome ?? '',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        profile?.email ?? '',
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      )
                  )
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text("Perfil"),
      ),
      body: profile != null
          ? ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ProfilePicture(
                imageData: profile.fotografia,
                size: 125,
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.all(8)),
          Text(
            profile.nome,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
          const Padding(padding: EdgeInsets.all(4)),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.tag),
            title: Text(
              profile.num_utilizador,
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
          ElevatedButton.icon(
            onPressed: showBottomSheet,
            icon: const Icon(Icons.badge), // Add the card icon here.
            label: const Text("Cartão Digital"),
          ),
        ],
      )
          : const ErrorView(error: "Erro a obter perfil"),
    );
  }
}