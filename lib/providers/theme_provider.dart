import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myipvc_budget_flutter/services/school_theme_parser.dart';
import 'package:myipvc_budget_flutter/ui/themes/ipvc.dart';

class ThemeNotifier extends StateNotifier<dynamic> {
  String school = "";

  ThemeNotifier() : super(IPVCTheme);

  void set(String type) {
    if (type == "school"){
      state = parseSchoolTheme(school);
    } else if (type == "device") {
      state = null;
    } else {
      state = IPVCTheme;
    }
  }

  void setSchool(String newSchool) {
    school = newSchool;
  }
}

final themeProvider = StateNotifierProvider<ThemeNotifier, dynamic>(
    (ref) => ThemeNotifier()
);