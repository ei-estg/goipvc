import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myipvc_budget_flutter/models/myipvc_user.dart';
import 'package:myipvc_budget_flutter/providers/profile_provider.dart';
import 'package:myipvc_budget_flutter/providers/sharedPreferencesProvider.dart';
import 'package:myipvc_budget_flutter/ui/themes/esce.dart';
import 'package:myipvc_budget_flutter/ui/themes/esdl.dart';
import 'package:myipvc_budget_flutter/ui/themes/ese.dart';
import 'package:myipvc_budget_flutter/ui/themes/ess.dart';
import 'package:myipvc_budget_flutter/ui/themes/estg.dart';
import 'package:myipvc_budget_flutter/ui/themes/ipvc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/settings.dart';

class SettingsNotifier extends StateNotifier<Settings> {
  final SharedPreferences sharedPreferences;
  final MyIPVCUser? profile;

  final Map<String, dynamic> _themeMap = HashMap.from({
    "ESA": ESTGTheme,
    "ESCE": ESCETheme,
    "ESDL": ESDLTheme,
    "ESE": ESETheme,
    "ESS": ESSTheme,
    "ESTG": ESTGTheme,
    "IPVC": IPVCTheme,
  });

  final Map<String, ThemeMode> _brightnessMap = HashMap.from({
    "system": ThemeMode.system,
    "dark": ThemeMode.dark,
    "light": ThemeMode.light,
  });

  final Map<String, Alignment> _alignmentMap = HashMap.from({
    "topLeft": Alignment.topLeft,
    "topCenter": Alignment.topCenter,
    "topRight": Alignment.topRight,
    "centerLeft": Alignment.centerLeft,
    "center": Alignment.center,
    "centerRight": Alignment.centerRight,
    "bottomLeft": Alignment.bottomLeft,
    "bottomCenter": Alignment.bottomCenter,
    "bottomRight": Alignment.bottomRight,
  });

  SettingsNotifier(this.sharedPreferences, this.profile)
    : super(Settings(
        theme: sharedPreferences.getString("theme") ?? 'default',
        brightness: sharedPreferences.getString("brightness") ?? 'system',
        pictureAlignment: sharedPreferences.getString("pictureAlignment") ?? 'center'
      ));

  void setTheme(String theme){
    sharedPreferences.setString("theme", theme);
    state = state.copyWith(theme: theme);
  }
  void setBrightness(String brightness){
    sharedPreferences.setString("brightness", brightness);
    state = state.copyWith(brightness: brightness);
  }
  void setPictureAlignment(String alignment){
    sharedPreferences.setString("pictureAlignment", alignment);
    state = state.copyWith(pictureAlignment: alignment);
  }

  dynamic getTheme() {
    if(state.theme == "school" && profile != null){
      return _themeMap[profile!.unidade_organica] ?? IPVCTheme;
    }

    return IPVCTheme;
  }

  ThemeMode getBrightness() {
    return _brightnessMap[state.brightness] ?? ThemeMode.system;
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