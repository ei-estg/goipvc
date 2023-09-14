import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myipvc_budget_flutter/providers/settings_provider.dart';

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
        return AlertDialog(
          title: const Text("Selecionar alinhamento da foto"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /*for(var alignment in ref.read(settingsProvider.notifier).getAlignmentMapKeys())
                ListTile(
                  title: Text(alignment),
                  onTap: () {
                    ref.read(settingsProvider.notifier).setPictureAlignment(alignment);
                    Navigator.pop(context);
                  },
                ),*/
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
          ),
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
          title: const Text("Alinhamento da foto"),
          onTap: () {
            _showAppearanceMenu(context, ref);
          },
          trailing: Text((() {
            return ref.read(settingsProvider.notifier).getAlignmentString();
          })()),
        )
      ],
    );
  }
}