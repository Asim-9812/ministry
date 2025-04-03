


import 'dart:isolate';
import 'dart:ui';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:ministry/src/core/resources/color_manager.dart';

class NotificationController {
  static ReceivePort? receivePort;


  static Future<void> initializeIsolateReceivePort() async {
    receivePort = ReceivePort('Notification action port in main isolate')
      ..listen(
              (silentData) => onActionReceivedImplementationMethod(silentData));

    // This initialization only happens on main isolate
    IsolateNameServer.registerPortWithName(
        receivePort!.sendPort, 'notification_action_port');
  }

  static Future<void> initializeNotifications() async {
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'reminders',
          channelName: 'Reminders',
          channelDescription: 'Notification for alarms',
          playSound: true,
          importance: NotificationImportance.High,
          defaultPrivacy: NotificationPrivacy.Private,
          defaultColor: MyColors.primary,
          ledColor: MyColors.primary,
          soundSource: 'resource://raw/res_alarm',
          defaultRingtoneType: DefaultRingtoneType.Ringtone,
        )
      ],
      debug: true,
    );
  }

  static Future<bool> checkPermission() async {
    return await AwesomeNotifications().isNotificationAllowed();
  }

  static Future<void> requestPermission() async {
    await AwesomeNotifications().requestPermissionToSendNotifications();
  }

  static Future<void> initialize() async {
    await initializeNotifications();
    await initializeIsolateReceivePort();

  }

  static Future<void> startListeningNotificationEvents() async {
    AwesomeNotifications()
        .setListeners(onActionReceivedMethod: onActionReceivedImplementationMethod);
  }

  static Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduleTime,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: id,
          channelKey: 'reminders',
          title: title,
          body: body,
          notificationLayout: NotificationLayout.Default,
          payload: {
            'Print' : 'this is printed'
          },
      ),
      schedule: NotificationCalendar(
        year: scheduleTime.year,
        month: scheduleTime.month,
        day: scheduleTime.day,
        hour: scheduleTime.hour,
        minute: scheduleTime.minute,
        second: scheduleTime.second,
        timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
        preciseAlarm: true,
      ),
    );
  }

  @pragma("vm:entry-point")
  static Future<void> onActionReceivedImplementationMethod(
      ReceivedAction receivedAction) async {
    print('notification for new');
    // Handle notification action here
  }
}
