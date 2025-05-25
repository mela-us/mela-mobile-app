import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> initNotifications() async {
  const android = AndroidInitializationSettings('@mipmap/ic_launcher');
  const ios = DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  const initSettings = InitializationSettings(android: android, iOS: ios);
  await flutterLocalNotificationsPlugin.initialize(initSettings);

  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Asia/Ho_Chi_Minh'));
}

Future<void> scheduleDailyNotifications() async {
  await flutterLocalNotificationsPlugin.cancelAll();

  //await _scheduleAtHourAndMinute(0, 6, 0);  // 6:00 sáng
  //await _scheduleAtHourAndMinute(1, 19, 0); // 19:00 tối

  //test
  await _scheduleAtHourAndMinute(2, 21, 20);
}

Future<void> _scheduleAtHourAndMinute(int id, int hour, int minute) async {
  final prefs = await SharedPreferences.getInstance();
  final notificationsEnabled = prefs.getBool('notifications_enabled') ?? true;
  final hasStreak = prefs.getBool(_todayKey()) ?? false;

  if (notificationsEnabled && !hasStreak) {
    final time = _nextInstanceOfHourAndMinute(hour, minute);
    print("Time set at $hour : $minute ");
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      '📚 Nhắc nhở học tập',
      'Đừng quên vào app để giữ streak nhé!',
      time,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_channel',
          'Daily Reminders',
          channelDescription: 'Nhắc nhở học tập hàng ngày',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      matchDateTimeComponents: DateTimeComponents.time,
      androidScheduleMode: AndroidScheduleMode.inexact,
    );
  }
}

tz.TZDateTime _nextInstanceOfHourAndMinute(int hour, int minute) {
  final now = tz.TZDateTime.now(tz.local);
  var scheduled = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
  if (scheduled.isBefore(now)) {
    scheduled = scheduled.add(const Duration(days: 1));
  }
  return scheduled;
}

String _todayKey() {
  final today = DateFormat('yyyyMMdd').format(DateTime.now());
  return 'streak_$today';
}

Future<void> markStreakIncreasedToday() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool(_todayKey(), true);
  await flutterLocalNotificationsPlugin.cancelAll(); // Hủy các thông báo còn lại
}
