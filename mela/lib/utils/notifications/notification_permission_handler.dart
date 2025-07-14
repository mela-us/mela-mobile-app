import 'dart:io';
import 'package:flutter/services.dart';

class NotificationPermissionHelper {
  static const _platform = MethodChannel('mela.channel/exact_alarm');

  static Future<void> requestExactAlarmPermission() async {
    if (!Platform.isAndroid) return;
    try {
      await _platform.invokeMethod('requestExactAlarmPermission');
    } on PlatformException catch (e) {
      print('Failed to request exact alarm permission: $e');
    }
  }
}
