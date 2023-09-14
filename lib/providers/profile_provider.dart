import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myipvc_budget_flutter/models/myipvc_user.dart';
import 'package:myipvc_budget_flutter/providers/sharedPreferencesProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final profileProvider = Provider<MyIPVCUser?>((ref) {
  SharedPreferences prefs = ref.watch(sharedPreferencesProvider);

  return MyIPVCUser.fromJson(jsonDecode(prefs.getString("user")!));
});
