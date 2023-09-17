import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myipvc_budget_flutter/models/settings.dart';
import 'package:myipvc_budget_flutter/providers/settings_provider.dart';
import 'package:myipvc_budget_flutter/providers/sharedPreferencesProvider.dart';
import 'package:myipvc_budget_flutter/ui/views/verify_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';

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
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          SfGlobalLocalizations.delegate
        ],
        // If only pt_PT worked correctly
        // WHY???
        supportedLocales: const [Locale("pt", "BR")],
        locale: const Locale("pt", "BR"),

        theme: settings.colorScheme == "system"
          ? ThemeData(
              colorScheme: lightColorScheme,
              useMaterial3: true,
            )
          : ref.read(settingsProvider.notifier).getColorScheme()["light"],
        darkTheme: settings.colorScheme == "system"
          ? ThemeData(
            colorScheme: darkColorScheme,
            useMaterial3: true,
          )
          : ref.read(settingsProvider.notifier).getColorScheme()["dark"],
        themeMode: ref.read(settingsProvider.notifier).getTheme(),
        debugShowCheckedModeBanner: false,
        home: const VerifyAuthView(),
      );
    });
  }
}

