



import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:intl/intl.dart';

Future<void> myGeneralNotifications({
  required Map<String,dynamic> allData
}) async {
  final reminderId = allData['reminderId'];
  final reminderTypeId = allData['reminderTypeId'];
  final title = allData['title'];
  final body = allData['body'];
  final startDate = DateTime.parse(allData['startDate']);
  final patternId = allData['patternId'];
  final hasRemindBefore = allData['hasRemindBefore'];
  int hasRemindType = 0;
  String hasRemind = '';
  int hasRemindInterval = 0;
  List<dynamic> specificDays = [];
  int interval = 0;
  final now =DateTime.now();
  final remindDate = DateTime(now.year,now.month,now.day,startDate.hour,startDate.minute);
  final initialId = (reminderId*100);
  final local = await AwesomeNotifications().getLocalTimeZoneIdentifier();

  NotificationContent content = NotificationContent(
    id: reminderId,
    channelKey: 'gen_alerts',
    title: title,
    body: body,
    category: NotificationCategory.Alarm,
    timeoutAfter: Duration(minutes: 1),
    autoDismissible: false,
    displayOnBackground: true,
    displayOnForeground: true,
    criticalAlert: true,
    payload: {
      'reminderId' : reminderId.toString(),
      'reminderTypeId' : reminderTypeId.toString()
    }
  );

  NotificationSchedule schedule = NotificationCalendar(
    year: remindDate.year,
    month: remindDate.month,
    day: remindDate.day,
    hour: remindDate.hour,
    minute: remindDate.minute,
    timeZone: local
  );

  if(patternId == 1){
    NotificationSchedule onceSchedule = NotificationCalendar(
        year: startDate.year,
        month: startDate.month,
        day: startDate.day,
        hour: startDate.hour,
        minute: startDate.minute,
        timeZone: local
    );
    if(hasRemindBefore){
      hasRemindType = allData['hasRemindType'];
      hasRemindInterval = allData['hasRemindInterval'];
      hasRemind = allData['hasRemind'];
      Duration duration = hasRemindType == 1 ? Duration(days: hasRemindInterval) : hasRemindType == 2 ? Duration(hours: hasRemindInterval) : Duration(minutes: hasRemindInterval);
      final initialDate = startDate.subtract(duration);
      NotificationSchedule initialSchedule = NotificationCalendar(
          year: initialDate.year,
          month: initialDate.month,
          day: initialDate.day,
          hour: initialDate.hour,
          minute: initialDate.minute,
          timeZone: local
      );
      NotificationContent initialContent = NotificationContent(
          id: initialId,
          channelKey: 'gen_alerts',
          title: title,
          body: 'It\'s $hasRemindInterval $hasRemind before $title',
          autoDismissible: false,
          displayOnBackground: true,
          displayOnForeground: true,
          criticalAlert: true,
          payload: {
            'reminderId' : reminderId.toString(),
            'reminderTypeId' : reminderTypeId.toString()
          }
      );
      await AwesomeNotifications().createNotification(
          schedule: initialSchedule,
          content: initialContent
      );
    }
    await AwesomeNotifications().createNotification(
        schedule: onceSchedule,
        content: content,
        actionButtons: [
          NotificationActionButton(key: '1', label: 'Snooze',actionType: ActionType.SilentAction),
          NotificationActionButton(key: '2', label: 'Dismiss',actionType: ActionType.DismissAction)
        ]
    );
  }
  if(patternId == 2){
    if(startDate.isAfter(now)){
      if(hasRemindBefore){
        hasRemindType = allData['hasRemindType'];
        hasRemindInterval = allData['hasRemindInterval'];
        hasRemind = allData['hasRemind'];
        Duration duration = hasRemindType == 1 ? Duration(days: hasRemindInterval) : hasRemindType == 2 ? Duration(hours: hasRemindInterval) : Duration(minutes: hasRemindInterval);
        final initialDate = remindDate.subtract(duration);
        NotificationSchedule initialSchedule = NotificationCalendar(
            year: initialDate.year,
            month: initialDate.month,
            day: initialDate.day,
            hour: initialDate.hour,
            minute: initialDate.minute,
            timeZone: local
        );
        NotificationContent initialContent = NotificationContent(
            id: initialId,
            channelKey: 'gen_alerts',
            title: title,
            body: 'It\'s $hasRemindInterval $hasRemind before $title',
            autoDismissible: false,
            displayOnBackground: true,
            displayOnForeground: true,
            criticalAlert: true,
            payload: {
              'reminderId' : reminderId.toString(),
              'reminderTypeId' : reminderTypeId.toString()
            }
        );
        await AwesomeNotifications().createNotification(
            schedule: initialSchedule,
            content: initialContent
        );
      }
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

  if(patternId == 3){
    specificDays = allData['specificDays'] as List<dynamic>;
    String day  = DateFormat('EEEE').format(now);
    if(startDate.isAfter(now) && specificDays.contains(day)){
      if(hasRemindBefore){
        hasRemindType = allData['hasRemindType'];
        hasRemindInterval = allData['hasRemindInterval'];
        hasRemind = allData['hasRemind'];
        Duration duration = hasRemindType == 1 ? Duration(days: hasRemindInterval) : hasRemindType == 2 ? Duration(hours: hasRemindInterval) : Duration(minutes: hasRemindInterval);
        final initialDate = remindDate.subtract(duration);
        NotificationSchedule initialSchedule = NotificationCalendar(
            year: initialDate.year,
            month: initialDate.month,
            day: initialDate.day,
            hour: initialDate.hour,
            minute: initialDate.minute,
            timeZone: local
        );
        NotificationContent initialContent = NotificationContent(
            id: initialId,
            channelKey: 'gen_alerts',
            title: title,
            body: 'It\'s $hasRemindInterval $hasRemind before $title',
            autoDismissible: false,
            displayOnBackground: true,
            displayOnForeground: true,
            criticalAlert: true,
            payload: {
              'reminderId' : reminderId.toString(),
              'reminderTypeId' : reminderTypeId.toString()
            }
        );
        await AwesomeNotifications().createNotification(
            schedule: initialSchedule,
            content: initialContent
        );
      }
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

  if(patternId == 4){
    interval = allData['interval'];
    int difference = now.difference(startDate).inDays;
    bool isTheDay = (difference % interval == 0);
    if(startDate.isAfter(now) && isTheDay){
      if(hasRemindBefore){
        hasRemindType = allData['hasRemindType'];
        hasRemindInterval = allData['hasRemindInterval'];
        hasRemind = allData['hasRemind'];
        Duration duration = hasRemindType == 1 ? Duration(days: hasRemindInterval) : hasRemindType == 2 ? Duration(hours: hasRemindInterval) : Duration(minutes: hasRemindInterval);
        final initialDate = remindDate.subtract(duration);
        NotificationSchedule initialSchedule = NotificationCalendar(
            year: initialDate.year,
            month: initialDate.month,
            day: initialDate.day,
            hour: initialDate.hour,
            minute: initialDate.minute,
            timeZone: local
        );
        NotificationContent initialContent = NotificationContent(
            id: initialId,
            channelKey: 'gen_alerts',
            title: title,
            body: 'It\'s $hasRemindInterval $hasRemind before $title',
            autoDismissible: false,
            displayOnBackground: true,
            displayOnForeground: true,
            criticalAlert: true,
            payload: {
              'reminderId' : reminderId.toString(),
              'reminderTypeId' : reminderTypeId.toString()
            }
        );

        await AwesomeNotifications().createNotification(
            schedule: initialSchedule,
            content: initialContent
        );
      }

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