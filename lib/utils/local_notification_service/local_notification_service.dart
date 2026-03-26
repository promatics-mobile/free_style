import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../common_constants.dart';

@pragma('vm:entry-point')
void onDidReceiveTapNotificationResponse(NotificationResponse? response) async {
  debugPrint("On Tap Notification : ${response!.payload.toString()} ");
}

@pragma('vm:entry-point')
void onDidReceiveNotificationResponse(NotificationResponse? notificationResponse) async {
  debugPrint("On Did Received Notification : ${notificationResponse!.payload.toString()} ");

  try {
    var message = jsonDecode(notificationResponse.payload.toString());
    String type = message['module'] ?? "";

    switch (type) {
      case 'battle':
        debugPrint("Module: battle");
        break;
      default:
        break;
    }
  } catch (e) {
    debugPrint("Error parsing payload: $e");
  }
}

class LocalNotificationService {
  /// Constants for Channel IDs
  static const String _basicChannelId = "free_style_basic_channel";
  static const String _soundChannelId = "free_style_custom_sound_channel";

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    /// Initialize Timezones once
    tz.initializeTimeZones();

    /// Platform Settings
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
      onDidReceiveBackgroundNotificationResponse: onDidReceiveTapNotificationResponse,
      settings: initializationSettings,
    );

    /// Register Channels with MAX Importance for Heads-up
    final androidPlugin = flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();

    await androidPlugin?.createNotificationChannel(
      const AndroidNotificationChannel(
        _basicChannelId,
        "Basic Notifications",
        importance: Importance.max,
        playSound: true,
        enableVibration: true,
        showBadge: true,
      ),
    );

    await androidPlugin?.createNotificationChannel(
      const AndroidNotificationChannel(
        _soundChannelId,
        "Sound Notifications",
        importance: Importance.max,
        playSound: true,
        showBadge: true,
        enableVibration: true,
      ),
    );
  }

  /// --- Private Helpers for Notification Details ---

  NotificationDetails _getPlatformDetails({bool withSound = false}) {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        withSound ? _soundChannelId : _basicChannelId,
        withSound ? "Sound Notifications" : "Basic Notifications",
        importance: Importance.max,
        priority: Priority.high,
        color: CommonColors.themeColor,
        playSound: true,
        enableVibration: true,
        fullScreenIntent: true, // Helps with banners on some Android versions
        category: AndroidNotificationCategory.message,
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
        presentBanner: true, // Force banner in foreground
        presentList: true,
      ),
    );
  }

  /// --- Public Methods ---

  void createNotification({
    required String title,
    required String message,
    required int id,
    Map<String, dynamic> param = const {},
  }) async {
    await flutterLocalNotificationsPlugin.show(
      id: id,
      title: title,
      body: message,
      notificationDetails: _getPlatformDetails(),
      payload: jsonEncode(param),
    );
  }

  void createNotificationWithSound({
    required String title,
    required String message,
    required int id,
    Map<String, dynamic> param = const {},
  }) async {
    await flutterLocalNotificationsPlugin.show(
      id: id,
      title: title,
      body: message,
      notificationDetails: _getPlatformDetails(withSound: true),
      payload: jsonEncode(param),
    );
  }

  void createScheduleNotification({
    required String title,
    required String message,
    required int id,
    required String dateTime,
    Map<String, dynamic> param = const {},
    bool withSound = false,
    DateTimeComponents? matchDateTimeComponents,
  }) async {
    try {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        id: id,
        title:title,
        body:message,
        notificationDetails :_getPlatformDetails(withSound: withSound),
        scheduledDate: tz.TZDateTime.from(DateTime.parse(dateTime), tz.local),
        androidScheduleMode: AndroidScheduleMode.alarmClock,
        payload: jsonEncode(param),
        matchDateTimeComponents: matchDateTimeComponents,
      );
    } catch (e) {
      debugPrint("Scheduling Error: $e");
    }
  }
}