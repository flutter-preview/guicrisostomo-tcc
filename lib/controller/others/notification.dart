// import 'package:awesome_notifications/awesome_notifications.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tcc/globals.dart' as globals;

class NotificationController {
  static NotificationController? _instance;
  static NotificationController get instance {
    _instance ??= NotificationController();
    return _instance!;
  }

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  bool _initialized = false;

  void init() async {
    if (!_initialized) {
      _initialized = true;

      var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/hungry');
      var initializationSettings = InitializationSettings(android: initializationSettingsAndroid);

      await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveBackgroundNotificationResponse: onSelectNotification,
        onDidReceiveNotificationResponse: onSelectNotification,
      );
    }
  }

  Future<void> showNotification(
    String title, 
    String body,
    List<String> listActions
  ) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channelId',
      'channelName',
      channelDescription: 'channelDescription',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
      enableLights: true,
      icon: '@mipmap/hungry',
      showWhen: true,
      visibility: NotificationVisibility.public,
      actions: listActions.map((item) {
        return AndroidNotificationAction(
          item,
          item,
        );
      }).toList(),
    );
    var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics, iOS: null);

    await flutterLocalNotificationsPlugin.show(0, title, body, platformChannelSpecifics, payload: '');
  }

  Future<void> onSelectNotification(NotificationResponse notificationResponse) async {
    print(notificationResponse.actionId);
    
    Map<String, dynamic> data = jsonDecode(notificationResponse.payload!);

      if (data['type'] == 'order') {
        navigatorKey.currentState!.pushNamed('/order', arguments: data['id']);
      }

    print(data.entries.toList());
    print(notificationResponse.payload);

    print(notificationResponse.payload);


  }
}