// import 'package:awesome_notifications/awesome_notifications.dart';
import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationController {
  static NotificationController? _instance;
  static NotificationController get instance {
    _instance ??= NotificationController();
    return _instance!;
  }
  
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static bool _initialized = false;

  static final StreamController<List<String?>> _streamController = StreamController<List<String?>>.broadcast();

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
      'table',
      'Mesa',
      channelDescription: 'Notificações referentes aos chamados de mesa',
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
          showsUserInterface: true,
        );
      }).toList(),

      onlyAlertOnce: false,
      usesChronometer: true,
    );
    var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics, iOS: null);

    await flutterLocalNotificationsPlugin.show(0, title, body, platformChannelSpecifics, payload: 'notify');
  }

  static void onSelectNotification(NotificationResponse notificationResponse, [Function? callback]) {
    _streamController.add([notificationResponse.payload, notificationResponse.actionId]);
  }

  Stream<List<String?>> get stream => _streamController.stream;
}