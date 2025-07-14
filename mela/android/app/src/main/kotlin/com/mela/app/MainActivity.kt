package com.mela.app

import android.app.AlarmManager
import android.content.Context
import android.content.Intent
import android.os.Build
import android.os.Bundle
import android.provider.Settings
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "mela.channel/exact_alarm"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "requestExactAlarmPermission") {
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
                    val alarmManager = getSystemService(Context.ALARM_SERVICE) as AlarmManager
                    val canSchedule = alarmManager.canScheduleExactAlarms()

                    if (!canSchedule) {
                        val intent = Intent(Settings.ACTION_REQUEST_SCHEDULE_EXACT_ALARM)
                        startActivity(intent)
                    }
                }
                result.success(null)
            } else {
                result.notImplemented()
            }
        }
    }
}
