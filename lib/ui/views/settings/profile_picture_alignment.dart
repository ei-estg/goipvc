import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goipvc/providers/settings_provider.dart';
import 'package:goipvc/ui/widgets/profile_picture.dart';

import '../../../models/myipvc/user.dart';
import '../../../providers/profile_provider.dart';

class ProfilePictureAlignmentControls extends ConsumerWidget {
  const ProfilePictureAlignmentControls({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    MyIPVCUser? profile = ref.watch(profileProvider);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if(profile != null)
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
              child: ProfilePicture(imageData: profile.fotografia, size: 96)
          ),

        DropdownMenu<String>(
          dropdownMenuEntries: <DropdownMenuEntry<String>>[
            for(var alignment in ref.read(settingsProvider.notifier).getAlignmentMapKeys())
              DropdownMenuEntry<String>(
                value: alignment,
                label: alignment,
              ),
          ],
          initialSelection: ref.read(settingsProvider).pictureAlignment,
          label: const Text("Alinhamento"),
          onSelected: (String? alignment) {
            ref.read(settingsProvider.notifier)
                .setPictureAlignment(alignment ?? "center");
          },
        )
      ],
    );
  }
}

class _PopUpNotifier extends StateNotifier<bool> {
  _PopUpNotifier() : super(false);

  void set(bool val) {
    state = val;
  }
}

final _popUpProvider = StateNotifierProvider<_PopUpNotifier, bool>(
        (ref) => _PopUpNotifier()
);

class ProfilePictureAlignmentSettings<T> extends ConsumerWidget {
  const ProfilePictureAlignmentSettings({super.key});

  void _showAppearanceMenu(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          title: Text("Alinhamento de foto", textAlign: TextAlign.center),
          content: ProfilePictureAlignmentControls(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(_popUpProvider);
    ref.watch(settingsProvider);

    return Wrap(
      children: <Widget>[
        ListTile(
          leading: const Icon(Icons.account_circle),
          title: const Text("Alinhamento da foto"),
          onTap: () {
            _showAppearanceMenu(context, ref);
          },
          trailing: Text(ref.read(settingsProvider.notifier).getAlignmentString()),
        )
      ],
    );
  }
}