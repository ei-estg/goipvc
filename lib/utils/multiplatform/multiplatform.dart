import 'dart:io' as io;

import 'package:flutter/foundation.dart';
enum Platform { android, ios, web }

Platform getPlatform() {
  if (kIsWeb) return Platform.web;
  if (io.Platform.isIOS) return Platform.ios;
  if (io.Platform.isAndroid) return Platform.android;
  throw UnsupportedError("unsupported platform");
}