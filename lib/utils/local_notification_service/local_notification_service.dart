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
  debugPrint("On Tab Notification : ${response!.payload.toString()} ");
  var payloadParse = jsonDecode(response.payload ?? "{}");
  //whenPressNotification(payloadParse);
}

@pragma('vm:entry-point')
void onDidReceiveNotificationResponse(NotificationResponse? notificationResponse) async {
  debugPrint("On Did Received Notification : ${notificationResponse!.payload.toString()} ");

  var message = jsonDecode(notificationResponse.payload.toString());

  String type = message['module'] ?? "";
  String operationId = message['operation_on_id'] ?? "";
  debugPrint("type:::::: $type");

  switch (type) {
    case 'indent':
      debugPrint("Module: Indent");
      break;
    case 'status_update_purchase_order':
      break;

    default:
  }
}

class LocalNotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    if (Platform.isIOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(alert: true, badge: false, sound: true);
    } else {
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();
      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
    }
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: false,
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

    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(
          const AndroidNotificationChannel("free_style_basic_channel", "free_style_basic_channel"),
        );

    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(
          const AndroidNotificationChannel(
            "free_style_custom_sound_channel",
            "free_style_custom__sound_channel",
            playSound: true,
          ),
        );
  }

  final AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
    "free_style_basic_channel",
    "free_style_basic_channel",
    channelDescription: "free_style_basic_channel",
    importance: Importance.high,
    priority: Priority.high,
    color: CommonColors.themeColor,
    playSound: true,
    enableVibration: true,
    visibility: NotificationVisibility.public,
    audioAttributesUsage: AudioAttributesUsage.notification,
    category: AndroidNotificationCategory.message,
  );

  final AndroidNotificationDetails androidPlatformWithSoundChannelSpecifics =
      AndroidNotificationDetails(
        "free_style_custom_sound_channel",
        "free_style_custom_sound_channel",
        channelDescription: "free_style_custom_sound_channel",
        importance: Importance.high,
        priority: Priority.high,
        color: CommonColors.themeColor,
        playSound: true,
        enableVibration: true,
        audioAttributesUsage: AudioAttributesUsage.notification,
        category: AndroidNotificationCategory.message,
      );

  final DarwinNotificationDetails iOSPlatformChannelSpecifics = const DarwinNotificationDetails(
    categoryIdentifier: "free_style_IOS_channel",
    threadIdentifier: "free_style_IOS_channel",
    presentAlert: true,
    presentBadge: false,
    presentSound: false,
  );

  final DarwinNotificationDetails iOSPlatformWithSoundChannelSpecifics =
      const DarwinNotificationDetails(
        categoryIdentifier: "free_style_custom_sound_IOS_channel",
        threadIdentifier: "free_style_custom_sound_IOS_channel",
        presentAlert: true,
        presentBadge: false,
        presentSound: true,
      );

  void createNotification({
    required String title,
    required String message,
    required String type,
    required int id,
    Map<String, dynamic> param = const {},
  }) async {
    final NotificationDetails platformChannelSpecifics = (Platform.isAndroid)
        ? NotificationDetails(android: androidPlatformChannelSpecifics)
        : NotificationDetails(iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      id: id,
      title: title,
      body: message,
      notificationDetails: platformChannelSpecifics,
      payload: jsonEncode(param),
    );
  }

  void createNotificationWithSound({
    required String title,
    required String message,
    required String type,
    required int id,
    Map<String, dynamic> param = const {},
  }) async {
    final NotificationDetails platformChannelSpecifics = (Platform.isAndroid)
        ? NotificationDetails(android: androidPlatformWithSoundChannelSpecifics)
        : NotificationDetails(iOS: iOSPlatformWithSoundChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      id: id,
      title: title,
      body: message,
      notificationDetails: platformChannelSpecifics,
      payload: jsonEncode(param),
    );
  }

  void createScheduleNotification({
    required String title,
    required String message,
    required int id,
    required String dateTime,
    Map<String, dynamic> param = const {},
  }) async {
    final NotificationDetails platformChannelSpecifics = (Platform.isAndroid)
        ? NotificationDetails(android: androidPlatformChannelSpecifics)
        : NotificationDetails(iOS: iOSPlatformChannelSpecifics);

    tz.initializeTimeZones();
    debugPrint("createScheduleNotification date time $dateTime");
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id: id,
      title: title,
      body: message,
      scheduledDate: tz.TZDateTime.from(DateTime.parse(dateTime), tz.local),
      notificationDetails: platformChannelSpecifics,
      payload: jsonEncode(param),
      androidScheduleMode: AndroidScheduleMode.alarmClock,
    );
    debugPrint("tzTime ${tz.TZDateTime.from(DateTime.parse(dateTime), tz.local)}");
  }

  void createScheduleNotificationWithSound({
    required String title,
    required String message,
    required int id,
    required String dateTime,
    Map<String, dynamic> param = const {},
    required String soundFileName,
    required DateTimeComponents? dateTimeComponents,
  }) async {
    final NotificationDetails platformChannelSpecifics = (Platform.isAndroid)
        ? NotificationDetails(android: androidPlatformWithSoundChannelSpecifics)
        : NotificationDetails(iOS: iOSPlatformWithSoundChannelSpecifics);

    tz.initializeTimeZones();
    debugPrint("createScheduleNotification date time $dateTime");
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id: id,
      title: title,
      body: message,
      scheduledDate: tz.TZDateTime.from(DateTime.parse(dateTime), tz.local),
      notificationDetails: platformChannelSpecifics,
      payload: jsonEncode(param),
      androidScheduleMode: AndroidScheduleMode.alarmClock,
      matchDateTimeComponents: dateTimeComponents,
    );
    debugPrint("tzTime ${tz.TZDateTime.from(DateTime.parse(dateTime), tz.local)}");
  }
}
