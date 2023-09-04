import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:myipvc_budget_flutter/ui/views/login.dart';

void main() {
  runApp(const MyIPVCApp());
}

class MyIPVCApp extends StatelessWidget {
  const MyIPVCApp({super.key});

  static final _defaultLightColorScheme = ColorScheme.fromSwatch(primarySwatch: Colors.blue);
  static final _defaultDarkColorScheme = ColorScheme.fromSwatch(primarySwatch: Colors.blue, brightness: Brightness.dark);

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme) {
      return MaterialApp(
        title: 'my ipvc',
        theme: ThemeData(
          colorScheme: lightColorScheme ?? _defaultLightColorScheme,
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          colorScheme: darkColorScheme ?? _defaultDarkColorScheme,
          useMaterial3: true,
        ),
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        home: const LoginView(),
      );
    });
  }
}

