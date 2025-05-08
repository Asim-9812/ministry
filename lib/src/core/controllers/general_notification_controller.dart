


import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';





class GeneralNotificationController{

  static Future<void> setScheduledNotification({required Map<String, dynamic> inputData}) async {

    final reminder = inputData;

    final timezone = await AwesomeNotifications().getLocalTimeZoneIdentifier();

    final reminderId = reminder['reminderId'];

    final reminderType = reminder['reminderType'];


    final title = reminder['title'];

    final body = reminder['body'];

    final patternId = reminder['patternId'];

    final daysOfWeek = patternId != 3 ? [] : reminder['daysOfWeek'].map((e)=>e.toLowercase()).toList();


    final notificationId = reminderId * 2000;

    final now = DateTime.now();

    final today = DateFormat('EEEE').format(now).toLowerCase();

    final time = DateTime.parse(reminder['startDate']);



    if(DateUtils.isSameDay(time, now) || now.isAfter(time)){

      NotificationContent content = NotificationContent(
          id: notificationId,
          channelKey: 'reminders',
          title: title,
          body: body,
          criticalAlert: true,
          autoDismissible: false,
          locked: true,
          wakeUpScreen: true,
          timeoutAfter: Duration(minutes: 1),
          displayOnBackground: true,
          displayOnForeground: true,
          // notificationLayout: NotificationLayout.Default,
          category: NotificationCategory.Alarm,
          payload: {
            'reminderId':reminderId.toString(),
            'reminderTypeId' : reminderType.toString(),
            'notificationId' : notificationId.toString(),
            'title' : title,
            'body' : body
          }
      );

      NotificationSchedule schedule = NotificationCalendar(
          year: now.year,
          month: now.month,
          day: now.day,
          hour: time.hour,
          minute: time.minute,
          timeZone: timezone
      );

      if(patternId != 3){
        await AwesomeNotifications().createNotification(
            schedule: schedule,
            content: content,
            actionButtons: [
              NotificationActionButton(key: '1', label: 'Snooze',actionType: ActionType.SilentAction),
              NotificationActionButton(key: '2', label: 'Dismiss',actionType: ActionType.DismissAction)
            ]
        );
      }
      else{
        if(daysOfWeek.contains(today)){

          await AwesomeNotifications().createNotification(
              schedule: schedule,
              content: content,
              actionButtons: [
                NotificationActionButton(key: '1', label: 'Snooze',actionType: ActionType.SilentAction),
                NotificationActionButton(key: '2', label: 'Dismiss',actionType: ActionType.DismissAction)
              ]
          );

        }
      }


    }


  }


  static Future<void> setSnoozedNotification({required Map<String, String?> payload}) async {

    final timezone = await AwesomeNotifications().getLocalTimeZoneIdentifier();

    final notificationId = int.parse(payload['notificationId']!);

    final reminderId = int.parse(payload['reminderId']!);

    final reminderType = int.parse(payload['reminderTypeId']!);


    final title = payload['title'];

    final body = payload['body'];

    final date = DateTime.now().add(Duration(minutes: 5));


    NotificationContent content = NotificationContent(
        id: notificationId,
        channelKey: 'reminders',
        title: title,
        body: body,
        criticalAlert: true,
        autoDismissible: false,
        locked: true,
        wakeUpScreen: true,
        timeoutAfter: Duration(minutes: 1),
        displayOnBackground: true,
        displayOnForeground: true,
        // notificationLayout: NotificationLayout.Default,
        category: NotificationCategory.Alarm,
        payload: {
          'reminderId':reminderId.toString(),
          'reminderTypeId' : reminderType.toString(),
          'notificationId' : notificationId.toString(),
          'title' : title,
          'body' : body
        }
    );

    NotificationSchedule schedule = NotificationCalendar(
        year: date.year,
        month: date.month,
        day: date.day,
        hour: date.hour,
        minute: date.minute,
        second: date.second,
        timeZone: timezone
    );


    await AwesomeNotifications().createNotification(
        schedule: schedule,
        content: content,
        actionButtons: [
          NotificationActionButton(key: '1', label: 'Snooze',actionType: ActionType.SilentAction),
          NotificationActionButton(key: '2', label: 'Dismiss',actionType: ActionType.DismissAction)
        ]
    );
  }



}