import 'package:goipvc/services/myipvc_api.dart';
import 'package:goipvc/services/notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch(task) {
      case "pt.joaoalves03.goipvc.lessonAlerts":
        await _scheduleLessonAlerts();
        break;
    }

    return Future.value(true);
  });
}

Future<void> _scheduleLessonAlerts() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if((prefs.getInt("lessonAlert") ?? 0) == 0) {
    return;
  }

  await Notifications.discardLessonWarningNotifications();
  final schedule = await MyIPVCAPI.getSchedule();
  await Notifications.parseSchedule(schedule);
}