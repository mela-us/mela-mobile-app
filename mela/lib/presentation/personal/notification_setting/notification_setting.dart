import 'package:flutter/material.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/notifications/notification_service.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  bool _notificationsEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadPreference();
  }

  Future<void> _loadPreference() async {
    final prefs = await SharedPreferences.getInstance();
    final isEnabled = prefs.getBool('streak_notifications_enabled') ?? true;
    setState(() {
      _notificationsEnabled = isEnabled;
    });
  }

  Future<void> _toggleNotifications(bool value) async {

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('streak_notifications_enabled', value);
    setState(() {
      _notificationsEnabled = value;
    });

    if (_notificationsEnabled) {
      NotificationService().scheduleNotification(hour: 6, minute: 0, notifyFromTomorrow: false);
      NotificationService().scheduleNotification(hour: 19, minute: 30, notifyFromTomorrow: false);
    }
    else {
      NotificationService().cancelAllNotifications();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cài đặt thông báo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Thông báo giữ chuỗi hằng ngày",
              style: Theme.of(context).textTheme.subHeading
                  .copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600
              ),
            ),
            Switch(
              value: _notificationsEnabled,
              onChanged: _toggleNotifications,
              activeColor: Theme.of(context).colorScheme.appBackground,
              activeTrackColor: Theme.of(context).colorScheme.tertiary,
              inactiveThumbColor: Theme.of(context).colorScheme.tertiary,
              inactiveTrackColor: Theme.of(context).colorScheme.appBackground,
              trackOutlineColor: WidgetStateProperty.resolveWith((states) {
                return Theme.of(context).colorScheme.tertiary;
              }),
            )

          ],
        ),
      ),
    );
  }
}
