import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myipvc_budget_flutter/providers/profile_provider.dart';
import 'package:myipvc_budget_flutter/providers/theme_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final futureThemeProvider = FutureProvider<void>((ref) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final profile = await ref.watch(profileProvider.future);
  final selectedOption = prefs.getString("theme");

  ref.read(themeProvider.notifier).setSchool(profile.unidade_organica);
  ref.read(themeProvider.notifier).set(selectedOption!);
});