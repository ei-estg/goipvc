import 'package:goipvc/services/myipvc_api.dart';
import 'package:goipvc/services/notifications.dart';
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
  await Notifications.discardLessonWarningNotifications();
  final schedule = await MyIPVCAPI.getSchedule();
  await Notifications.parseSchedule(schedule);
}