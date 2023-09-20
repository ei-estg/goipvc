import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goipvc/models/myipvc/lesson.dart';
import 'package:goipvc/services/myipvc_api.dart';

final scheduleProvider = FutureProvider<List<MyIPVCLesson>>((ref) async {
  return await MyIPVCAPI().getSchedule();
});