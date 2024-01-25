import 'package:dio/dio.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String?> getNewRelease() async{
  final response = await Dio().get(
    "https://api.github.com/repos/ei-estg/goipvc/releases/latest"
  );

  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  if(packageInfo.version != response.data["tag_name"].substring(1)){
    return response.data["tag_name"];
  }

  return null;
}

Future<bool> downloadUpdateAndroid() async {
  try {
    const fileURL =
        "https://github.com/ei-estg/goipvc/releases/latest/download/app-release-signed.apk";
    DefaultCacheManager cacheManager = DefaultCacheManager();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    FileInfo? fileInfo = await cacheManager.downloadFile(fileURL);

    prefs.setString("updated", fileInfo.originalUrl);

    await OpenFile.open(fileInfo.file.path,
        type: 'application/vnd.android.package-archive');

    return false;
  } catch(e) { return true; }
}

Future<void> checkIfAppWasUpdated() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  DefaultCacheManager cacheManager = DefaultCacheManager();

  String? fileName = prefs.getString("updated");

  if(fileName != null) {
    cacheManager.removeFile(fileName);
    prefs.remove("updated");
  }
}