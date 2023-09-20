import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goipvc/models/myipvc/user.dart';
import 'package:goipvc/providers/profile_provider.dart';
import 'package:goipvc/providers/sharedPreferencesProvider.dart';
import 'package:goipvc/ui/themes/esce.dart';
import 'package:goipvc/ui/themes/esdl.dart';
import 'package:goipvc/ui/themes/ese.dart';
import 'package:goipvc/ui/themes/ess.dart';
import 'package:goipvc/ui/themes/estg.dart';
import 'package:goipvc/ui/themes/ipvc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/settings.dart';
import '../ui/themes/esa.dart';

class SettingsNotifier extends StateNotifier<Settings> {
  final SharedPreferences sharedPreferences;
  final MyIPVCUser? profile;

  final Map<String, dynamic> _colorSchemeMap = HashMap.from({
    "ESA": ESATheme,
    "ESCE": ESCETheme,
    "ESDL": ESDLTheme,
    "ESE": ESETheme,
    "ESS": ESSTheme,
    "ESTG": ESTGTheme,
    "IPVC": IPVCTheme,
  });

  final Map<String, ThemeMode> _themeMap = HashMap.from({
    "system": ThemeMode.system,
    "dark": ThemeMode.dark,
    "light": ThemeMode.light,
  });

  final Map<String, Alignment> _alignmentMap = HashMap.from({
    "Cima": Alignment.topCenter,
    "Esquerda": Alignment.centerLeft,
    "Centro": Alignment.center,
    "Direita": Alignment.centerRight,
    "Baixo": Alignment.bottomCenter,
  });

  SettingsNotifier(this.sharedPreferences, this.profile)
    : super(Settings(
        colorScheme: sharedPreferences.getString("colorScheme") ?? 'system',
        theme: sharedPreferences.getString("theme") ?? 'system',
        pictureAlignment: sharedPreferences.getString("pictureAlignment") ?? 'Centro'
      ));

  void setTheme(String theme){
    sharedPreferences.setString("theme", theme);
    state = state.copyWith(theme: theme);
  }
  void setColorScheme(String colorScheme){
    sharedPreferences.setString("colorScheme", colorScheme);
    state = state.copyWith(colorScheme: colorScheme);
  }
  void setPictureAlignment(String alignment){
    sharedPreferences.setString("pictureAlignment", alignment);
    state = state.copyWith(pictureAlignment: alignment);
  }

  dynamic getColorScheme() {
    if(state.colorScheme == "school" && profile != null){
      return _colorSchemeMap[profile!.unidade_organica] ?? IPVCTheme;
    }

    return IPVCTheme;
  }

  ThemeMode getTheme() {
    return _themeMap[state.theme] ?? ThemeMode.system;
  }

  Alignment getPictureAlignment(){
    return _alignmentMap[state.pictureAlignment] ?? Alignment.center;
  }

  Iterable<String> getAlignmentMapKeys() {
    return _alignmentMap.keys;
  }

  String getAlignmentString(){
    return _alignmentMap.keys.firstWhere((element) =>
    _alignmentMap[element] == getPictureAlignment(),
        orElse: () => ""
    );
  }
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, Settings>(
  (ref) {
    final sharedPreferences = ref.watch(sharedPreferencesProvider);
    final profile = ref.watch(profileProvider);
    return SettingsNotifier(sharedPreferences, profile);
  },
);