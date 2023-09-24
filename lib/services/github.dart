import 'package:dio/dio.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

Future<String?> getNewRelease() async{
  final response = await Dio().get(
    "https://api.github.com/repos/joaoalves03/goipvc/releases/latest"
  );

  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  if(packageInfo.version != response.data["tag_name"].substring(1)){
    return response.data["tag_name"];
  }

  return null;
}

Future<void> downloadUpdateAndroid() async {
  const fileURL = "https://github.com/joaoalves03/goipvc/releases/latest/download/app-release-signed.apk";
  DefaultCacheManager cacheManager = DefaultCacheManager();

  FileInfo? fileInfo = await cacheManager.getFileFromCache(fileURL);

  if (fileInfo == null || fileInfo.validTill.isBefore(DateTime.now())) {
    fileInfo = await cacheManager.downloadFile(fileURL);
  }

  await OpenFile.open(fileInfo.file.path, type: 'application/vnd.android.package-archive');
}