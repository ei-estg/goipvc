import 'dart:io';
import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:goipvc/models/myipvc/lesson.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;

import '../providers/settings_provider.dart';

class Notifications {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid
      = AndroidInitializationSettings("@mipmap/ic_launcher");
    const DarwinInitializationSettings initializationSettingsDarwin
      = DarwinInitializationSettings(
        onDidReceiveLocalNotification: null
      );
    const LinuxInitializationSettings initializationSettingsLinux
      = LinuxInitializationSettings(defaultActionName: "Open notification");

    await _notificationsPlugin.initialize(
      const InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin,
        macOS: initializationSettingsDarwin,
        linux: initializationSettingsLinux
      )
    );
  }

  static Future<void> scheduleLessonWarningNotification(String name, DateTime startDate, int minsBefore) async {
    // Scheduled notifications are not implemented in these platforms
    if(Platform.isLinux || Platform.isWindows) {
      return;
    }

    const AndroidNotificationDetails androidNotificationDetails
      = AndroidNotificationDetails(
        "lessonAlert",
        "Aviso de aulas",
        channelDescription: "Avisar x minutos antes de uma aula começar",
        importance: Importance.defaultImportance,
        priority: Priority.defaultPriority
      );

    const NotificationDetails notificationDetails
      = NotificationDetails(android: androidNotificationDetails);

    DateTime notificationTime = startDate.subtract(const Duration(minutes: 5)).toUtc();

    var scheduledDate = tz.TZDateTime(
      tz.local,
      notificationTime.year,
      notificationTime.month,
      notificationTime.day,
      notificationTime.hour,
      notificationTime.minute,
      notificationTime.second
    );

    await _notificationsPlugin.zonedSchedule(
      Random().nextInt(2147483647),
      "Aviso de aula",
      "$name começa em ${SettingsNotifier.getLessonAlertString(minsBefore)}",
      scheduledDate,
      notificationDetails,
      matchDateTimeComponents: DateTimeComponents.time,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime
    );
  }

  static Future<void> discardLessonWarningNotifications() async {
    // Scheduled notifications are not implemented in these platforms
    if(Platform.isLinux || Platform.isWindows) {
      return;
    }

    await _notificationsPlugin.cancelAll();
  }

  static Future<void> parseSchedule(List<MyIPVCLesson> schedule) async {
    for(var lesson in schedule) {
      DateTime lessonDate = DateTime.parse(lesson.dataHoraIni);
      SharedPreferences prefs = await SharedPreferences.getInstance();

      if (lessonDate.difference(DateTime.now()).inSeconds > (prefs.getInt("lessonAlert") ?? 5) * 60) {
        await Notifications.scheduleLessonWarningNotification(
            lesson.sigla,
            lessonDate,
            prefs.getInt("lessonAlert") ?? 5
        );
      }
    }
  }
}