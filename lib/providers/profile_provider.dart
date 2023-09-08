import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myipvc_budget_flutter/models/myipvc_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

final profileProvider = FutureProvider<MyIPVCUser>((ref) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  return MyIPVCUser.fromJson(jsonDecode(prefs.getString("user")!));
});