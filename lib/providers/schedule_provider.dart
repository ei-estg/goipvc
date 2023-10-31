import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goipvc/models/myipvc/lesson.dart';
import 'package:goipvc/services/myipvc_api.dart';

import '../services/notifications.dart';

final scheduleProvider = FutureProvider<List<MyIPVCLesson>>((ref) async {
  final schedule = await MyIPVCAPI.getSchedule();

  // There are no awaits here so the notification parsing
  // doesn't slow down displaying the schedule
  Notifications.discardLessonWarningNotifications().then((_) => {
    Notifications.parseSchedule(schedule)
  });

  return schedule;
});