import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/myipvc_user.dart';
import '../../providers/profile_provider.dart';
import '../widgets/profile_picture.dart';
import 'error.dart';

enum Sides { front, back }

class SingleChoice extends StatefulWidget {
  const SingleChoice({super.key});

  @override
  State<SingleChoice> createState() => _SingleChoiceState();
}

class _SingleChoiceState extends State<SingleChoice> {
  Sides sidesView = Sides.front;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<Sides>(
      segments: const <ButtonSegment<Sides>>[
        ButtonSegment<Sides>(
            value: Sides.front,
            label: Text('Front'),
        ),
        ButtonSegment<Sides>(
            value: Sides.back,
            label: Text('Back'),
        )
      ],
      selected: <Sides>{sidesView},
      onSelectionChanged: (Set<Sides> newSelection) {
        setState(() {
          sidesView = newSelection.first;
        });
      },
    );
  }
}



class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    MyIPVCUser? profile = ref.watch(profileProvider);

    final scaffoldKey = GlobalKey<ScaffoldState>();

    Future<void> showBottomSheet(BuildContext context) async {
      await showModalBottomSheet(
        context: context,
        builder: (context) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 32, 0, 16),
                    child: SingleChoice(),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 16, 0, 32),
                    child: Text("Cartão"),
                  ),
                ],
              ),
            )
          );
        },
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
            onPressed: () {
              showBottomSheet(context);
            },
            icon: const Icon(Icons.badge), // Add the card icon here.
            label: const Text("Cartão Digital"),
          ),
        ],
      )
      : const ErrorView(error: "Erro a obter perfil"),
    );
  }
}