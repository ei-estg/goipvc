import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PictureAlignmentNotifier extends StateNotifier<Alignment> {
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

  PictureAlignmentNotifier() : super(Alignment.center);

  void set(String alignment) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("pictureAlignment",
      _alignmentMap.containsKey(alignment)
        ? alignment
        : "center"
    );

    state = _alignmentMap[alignment] ?? Alignment.center;
  }

  void fetch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    state = _alignmentMap[prefs.getString("pictureAlignment")]
            ?? Alignment.center;
  }

  Iterable<String> getKeys() {
    return _alignmentMap.keys;
  }

  Alignment toAlignment(String alignment){
    return _alignmentMap[alignment]!;
  }

  @override
  String toString() {
    var bruh =  _alignmentMap.keys.firstWhere((element) =>
      _alignmentMap[element] == state,
      orElse: () => ""
    );

    print(bruh);

    return bruh;
  }
}

final pictureAlignmentProvider = StateNotifierProvider<PictureAlignmentNotifier, Alignment>(
        (ref) => PictureAlignmentNotifier()
);