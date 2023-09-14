import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myipvc_budget_flutter/models/settings.dart';
import 'package:myipvc_budget_flutter/providers/settings_provider.dart';
import 'package:myipvc_budget_flutter/providers/sharedPreferencesProvider.dart';
import 'package:myipvc_budget_flutter/ui/views/verify_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(ProviderScope(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(sharedPreferences),
    ],
    child: const MyIPVCApp(),
  ));
}

class MyIPVCApp extends ConsumerWidget {
  const MyIPVCApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Settings settings = ref.watch(settingsProvider);

    return DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme) {
      return MaterialApp(
        title: 'my ipvc',
        theme: settings.theme == "device"
          ? ThemeData(
              colorScheme: lightColorScheme,
              useMaterial3: true,
            )
          : ref.read(settingsProvider.notifier).getTheme()["light"],
        darkTheme: settings.theme == "device"
          ? ThemeData(
            colorScheme: darkColorScheme,
            useMaterial3: true,
          )
          : ref.read(settingsProvider.notifier).getTheme()["dark"],
        themeMode: ref.read(settingsProvider.notifier).getBrightness(),
        debugShowCheckedModeBanner: false,
        home: const VerifyAuthView(),
      );
    });
  }
}

