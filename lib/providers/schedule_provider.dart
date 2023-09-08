import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myipvc_budget_flutter/models/myipvc_lesson.dart';
import 'package:myipvc_budget_flutter/services/myipvc_api.dart';

final scheduleProvider = FutureProvider<List<MyIPVCLesson>>((ref) async {
  return await MyIPVCAPI().getSchedule();
});