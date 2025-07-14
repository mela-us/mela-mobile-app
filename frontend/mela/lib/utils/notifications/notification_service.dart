import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final _plugin = FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  // INITIALIZE
  Future<void> initNotification() async {
    if (_isInitialized) return; // prevent re-initialization

    print("Init Notification");

    // init timezone handling
    tz.initializeTimeZones();
    String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    if (currentTimeZone == "Asia/Saigon") {
      currentTimeZone = "Asia/Ho_Chi_Minh";
    }
    tz.setLocalLocation(tz.getLocation(currentTimeZone));

    // prepare android init settings
    const initSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    // prepare ios init settings
    const initSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    // init settings
    const initSettings = InitializationSettings(
      android: initSettingsAndroid,
      iOS: initSettingsIOS,
    );

    //initialize the plugin
    await _plugin.initialize(initSettings);
  }

  // NOTIFICATIONS DETAIL SETUP
  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'daily_channel_id',
        'Thông báo hằng ngày',
        channelDescription: 'Thông báo nhắc nhở giữ chuỗi',
        importance: Importance.max,
        priority: Priority.high,
      ), // AndroidNotificationDetails
      iOS: DarwinNotificationDetails(),
    ); // NotificationDetails
  }

  // SHOW NOTIFICATION
  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
  }) async {
    return _plugin.show(
      id,
      title,
      body,
      notificationDetails(),
    );
  }

  Future<void> scheduleNotification({
    int id = 1,
    bool notifyFromTomorrow = true, //if not notify from now
    required int hour,
    required int minute,
  }) async {
    // Get the current date/time in device's local timezone
    final now = tz.TZDateTime.now(tz.local);

    // Create a date/time for today at the specified hour/min
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      notifyFromTomorrow ? now.day + 1 : now.day,
      hour,
      minute,
    );

    // Danh sách tiêu đề và nội dung
    final titles = [
      "Mela đây!",
      "+1 máy giữ chuỗi Mela",
      "Bạn của Mela ơi!",
      "Lời nhắc từ Mela",
    ];

    final bodies = [
      "Học cùng MELA thôi, do dự chuỗi không còn mất!",
      "Hôm nay bạn học chưa? MELA đang đợi đấy!",
      "Đừng quên nhiệm vụ học tập hôm nay nhé!",
      "Một chút học mỗi ngày giúp giữ chuỗi không gãy!",
    ];

    final random = Random();
    final randomTitle = titles[random.nextInt(titles.length)];
    final randomBody = bodies[random.nextInt(bodies.length)];

    print("Scheduling notification at $scheduledDate");

    // Schedule the notification
    await _plugin.zonedSchedule(
      id,
      randomTitle,
      randomBody,
      scheduledDate,
      notificationDetails(),

      // iOS specific: Use exact time specified (vs relative time)

      // Android specific: Allow notification while device is in low-power mode
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,

      // Make notification repeat DAILY at same time
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> cancelAllNotifications() async {
    await _plugin.cancelAll();
  }

  Future<void> scheduleAll() async {
    await scheduleNotification(hour: 6, minute: 00);
    await scheduleNotification(hour: 19, minute: 30);
  }

}
