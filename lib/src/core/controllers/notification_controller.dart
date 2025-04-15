


import 'dart:isolate';
import 'dart:ui';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:ministry/src/core/controllers/medicine_notification_controller.dart';
import 'package:ministry/src/core/resources/color_manager.dart';
import 'package:ministry/src/core/utils/page_route.dart';
import 'package:ministry/src/features/dashboard/presentation/ui/dashboard.dart';
import 'package:ministry/src/features/reminders/presentation/ui/pages/medicine_reminder.dart';

import '../../app/my_app.dart';

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

  static Future<void> delNotification({required int id}) async{
    await AwesomeNotifications().cancel(id);
  }

  static Future<void> startListeningNotificationEvents() async {
    AwesomeNotifications()
        .setListeners(
      onActionReceivedMethod: onActionReceivedImplementationMethod
    );
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
            'reminderId':'1001',
            'reminderTypeId' : '1',
            'title' : title,
            'body' : body
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
        actionButtons: [
          NotificationActionButton(key: '1', label: 'Snooze',actionType: ActionType.SilentAction),
          NotificationActionButton(key: '2', label: 'Dismiss',actionType: ActionType.DismissAction)
        ]
    );
  }

  @pragma("vm:entry-point")
  static Future<void> onActionReceivedImplementationMethod(ReceivedAction receivedAction) async {

    if(receivedAction.buttonKeyPressed.trim().isEmpty){

      final typeId = int.parse(receivedAction.payload!['reminderType']!);
      final reminderId = int.parse(receivedAction.payload!['reminderId']!);

      BuildContext context = MyApp.navigatorKey.currentContext!;

      if(typeId == '1'){ //medicine reminder
        routeTo(context, MedicineReminderInfo(reminderId: reminderId));
      }

      else if(typeId == '2'){ //general reminder
        // routeTo(context, MedicineReminderInfo(reminderId: reminderId));
      }

      else{
        routeTo(context, Dashboard());
      }

      await AwesomeNotifications().dismiss(reminderId);
    }
    else if(receivedAction.buttonKeyPressed == '1'){
      await MedicineNotificationController.setSnoozedNotification(payload: receivedAction.payload!);
    }
    else{
      print('it was dismissed');
    }


  }
}
