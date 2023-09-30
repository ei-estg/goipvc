import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goipvc/models/myipvc/user.dart';
import 'package:goipvc/providers/shared_preferences_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileNotifier extends StateNotifier<MyIPVCUser?> {
  final SharedPreferences sharedPreferences;

  ProfileNotifier(this.sharedPreferences) : super(
    sharedPreferences.getString("user") == null
        ? null
        : MyIPVCUser.fromJson(jsonDecode(sharedPreferences.getString("user")!))
  );

  void set(String profile) {
    sharedPreferences.setString("user", profile);
    state = MyIPVCUser.fromJson(jsonDecode(profile));
  }
}

final profileProvider = StateNotifierProvider<ProfileNotifier, MyIPVCUser?>((ref) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider);

  return ProfileNotifier(sharedPreferences);
});