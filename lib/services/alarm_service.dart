import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:cure/screens/pill_reminder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class AlarmService {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static Function(String)? _onAlarmTrigger;

  static Future<void> init(Function(void) onAlarmTrigger) async {
    _onAlarmTrigger = onAlarmTrigger;

    // Initialize notifications
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    await _notifications.initialize(
      const InitializationSettings(android: android),
      onDidReceiveNotificationResponse: (response) {
        if (response.payload != null) {
          _onAlarmTrigger!(response.payload!);
        }
      },
    );

    // Initialize alarm manager
    await AndroidAlarmManager.initialize();
  }

  static Future<void> schedulePillAlarm({
    required int id,
    required String pillName,
    required TimeOfDay? time,
  }) async {
    // Schedule notification
    final androidDetails = const AndroidNotificationDetails(
      'pill_channel',
      'Pill Reminders',
      importance: Importance.max,
      priority: Priority.high,
    );

    await _notifications.zonedSchedule(
      id,
      'Pill Reminder',
      'Time to take $pillName',
      tz.TZDateTime.now(
        tz.local,
      ).add(Duration(hours: time!.hour, minutes: time.minute)),
      NotificationDetails(android: androidDetails),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: pillName,
      androidScheduleMode: AndroidScheduleMode.exact,
    );

    // Schedule background callback
    await AndroidAlarmManager.periodic(
      const Duration(hours: 24), // Repeat every 24 hours
      id,
      _triggerAlarm,
      startAt: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        time.hour,
        time.minute,
      ),
      exact: true,
      wakeup: true,
      rescheduleOnReboot: true,
    );
  }

  @pragma('vm:entry-point')
  static void _triggerAlarm() {
    try {
      // Cannot get params directly; fallback to a default message
      const pillName = 'your medicine';
      Navigator.push(
        PillReminderScreen() as BuildContext,
        MaterialPageRoute(builder: (context) => PillReminderScreen()),
      );
      // Show notification
      _showPillNotification(pillName);

      // Trigger callback
      _onAlarmTrigger?.call(pillName);
    } catch (e) {
      debugPrint('Alarm error: $e');
    }
  }

  static Future<void> _showPillNotification(String pillName) async {
    await _notifications.show(
      0,
      'Pill Reminder',
      'Time to take $pillName',
      NotificationDetails(
        android: AndroidNotificationDetails(
          'pill_channel',
          'Pill Reminders',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      payload: pillName,
    );
  }
}
//  tz.TZDateTime _nextTime(TimeOfDay time) {
//   final now = tz.TZDateTime.now(tz.local);
//   var scheduled = tz.TZDateTime(
//     tz.local,
//     now.year,
//     now.month,
//     now.day,
//     time.hour,
//     time.minute,
//   );
//   if (scheduled.isBefore(now))
//     scheduled = scheduled.add(const Duration(days: 1));
//   return scheduled;
// }
