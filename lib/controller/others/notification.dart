import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:tcc/globals.dart' as globals;

class NotificationController {
  static NotificationController? _instance;
  static NotificationController get instance {
    if (_instance == null) _instance = NotificationController();
    return _instance!;
  }

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // final AndroidInitializationSettings initializationSettingsAndroid =
  //     const AndroidInitializationSettings('android/app/src/main/res/drawable-hdpi/splash.png');
  // final InitializationSettings initializationSettings = InitializationSettings(
  //     android: initializationSettingsAndroid);
  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> init([
    String channel = 'basic_channel',
    String channelGroup = 'basic_channel_group',
    String channelName = 'Mesas chamando',
    String channelGroupDescription = 'Notificações de mesas chamando para atendimento',
  ]) async {
    //Initialization Settings for Android

    // await flutterLocalNotificationsPlugin.initialize(
    //   initializationSettings,
    // );

    AwesomeNotifications().initialize(
      'resource://mipmap/hungry_white',
      [
        NotificationChannel(
            channelGroupKey: channelGroup,
            channelKey: channel,
            channelName: channelName,
            channelDescription: channelGroupDescription,
            defaultColor: globals.primary,
            ledColor: Colors.white,
            playSound: true,
            enableVibration: true,
            importance: NotificationImportance.High,
            enableLights: true,
            criticalAlerts: true,
          )
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: 'basic_channel_group',
            channelGroupName: 'Basic group')
      ],
      debug: true,
    );
  }

  Future<void> showNotificationWithActions(
      String title, String subTitle, List<String> textActions,
      [bool isImportant = false, String channel = 'basic_channel']) async {


    // const AndroidNotificationDetails androidNotificationDetails =
    //     AndroidNotificationDetails(
    //   'hungry',
    //   'channel',
    //   importance: isImportant ? Importance.max : Importance.defaultImportance,
    //   priority: isImportant ? Priority.high : Priority.defaultPriority,
    //   fullScreenIntent: isImportant,
    //   actions: <AndroidNotificationAction>[
    //     for (var i = 0; i < textActions.length; i++)
    //       AndroidNotificationAction('$i', textActions[i]),
    //   ],
    // );
    // NotificationDetails notificationDetails =
    //     NotificationDetails(android: androidNotificationDetails);
    // await flutterLocalNotificationsPlugin.show(
    //     0, title, subTitle, notificationDetails);

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: channel,
        title: title,
        body: subTitle,
        displayOnForeground: true,
        displayOnBackground: true,
        notificationLayout: NotificationLayout.BigPicture,
        largeIcon: 'resource://mipmap/hungry_white',
        bigPicture: 'resource://mipmap/hungry',
        showWhen: true,
        payload: {'uuid': 'user-profile-uuid'},
        locked: true,
        criticalAlert: true,
        color: globals.primary,
        backgroundColor: globals.primary,
      ),
      actionButtons: [
        for (var i = 0; i < textActions.length; i++)
          NotificationActionButton(
            key: '$i',
            label: textActions[i],
            enabled: true,
          )
      ],
    );
  }

  @pragma("vm:entry-point")
  static Future <void> onNotificationCreatedMethod(ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future <void> onNotificationDisplayedMethod(ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future <void> onDismissActionReceivedMethod(ReceivedAction receivedAction) async {
    // Your code goes here
  }

  @pragma("vm:entry-point")
  static Future <void> onActionReceivedMethod(ReceivedAction receivedAction, Function(ReceivedAction receivedAction) callback) async {
    // Your code goes here
    await callback(receivedAction);
  }

  // setListener(BuildContext context) {
  //   AwesomeNotifications().setListeners(
  //     onActionReceivedMethod: (ReceivedAction receivedAction) async {
  //       await  NotificationController.onActionReceivedMethod(context, receivedAction);

  //     },
  //     onNotificationCreatedMethod: (ReceivedNotification receivedNotification) async {
  //        await NotificationController.onNotificationCreatedMethod(context, receivedNotification);
  //     },
  //     onNotificationDisplayedMethod: (ReceivedNotification receivedNotification) async {
  //         await NotificationController.onNotificationDisplayedMethod(context, receivedNotification);
  //     },
  //     onDismissActionReceivedMethod: (ReceivedAction receivedAction) async {
  //         await NotificationController.onDismissActionReceivedMethod(context, receivedAction);
  //     },
  // );
  // }
}