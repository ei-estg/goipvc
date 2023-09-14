import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myipvc_budget_flutter/models/myipvc_user.dart';
import 'package:myipvc_budget_flutter/providers/sharedPreferencesProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
final profileProvider = Provider<MyIPVCUser?>((ref) {
  SharedPreferences prefs = ref.watch(sharedPreferencesProvider);

  final profile = prefs.getString("user");

  if(profile == null) {
    return null;
  }

  return MyIPVCUser.fromJson(jsonDecode(profile));
});*/


class ProfileNotifier extends StateNotifier<MyIPVCUser?> {
  final SharedPreferences sharedPreferences;

  ProfileNotifier(this.sharedPreferences) : super(
    sharedPreferences.getString("user") == null
        ? null
        : MyIPVCUser.fromJson(jsonDecode(sharedPreferences.getString("user")!))
  );

  void set(String profile) {
    state = MyIPVCUser.fromJson(jsonDecode(profile));
  }
}

final profileProvider = StateNotifierProvider<ProfileNotifier, MyIPVCUser?>((ref) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider);

  return ProfileNotifier(sharedPreferences);
});