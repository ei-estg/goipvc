import 'package:dio/dio.dart';
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