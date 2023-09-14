import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myipvc_budget_flutter/providers/future_theme_provider.dart';
import 'package:myipvc_budget_flutter/providers/theme_provider.dart';
import 'package:myipvc_budget_flutter/ui/views/verify_auth.dart';

void main() {
  runApp(const ProviderScope(
    child: MyIPVCApp(),
  ));
}

class MyIPVCApp extends ConsumerWidget {
  const MyIPVCApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(futureThemeProvider);
    final theme = ref.watch(themeProvider);

    return DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme) {
      return MaterialApp(
        title: 'my ipvc',
        theme: theme == null
          ? ThemeData(
              colorScheme: lightColorScheme,
              useMaterial3: true,
            )
          : theme["light"],
        darkTheme: theme == null
          ? ThemeData(
            colorScheme: darkColorScheme,
            useMaterial3: true,
          )
          : theme["dark"],
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        home: const VerifyAuthView(),
      );
    });
  }
}

