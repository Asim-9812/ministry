




import 'package:awesome_notifications/awesome_notifications.dart';

import '../../features/reminders/domain/model/reminder_model.dart';

class MedicineNotificationController{

  static Future<void> setScheduledNotification({required ReminderModel reminder}) async {

    final timezone = await AwesomeNotifications().getLocalTimeZoneIdentifier();

    final reminderId = reminder.reminderId;

    final reminderType = reminder.reminderType;

    final medicine = reminder.medicineReminder!;

    final title = medicine.medicineName;

    final body = 'Time for your medicine. ${medicine.strength}${medicine.unit.units} ${medicine.meal.name}';

    List<DateTime> dateList = medicine.dateList;

    List<DateTime> timeRange = dateList.where((element){
      final now = DateTime.now();
      final tmrw = DateTime.now().add(Duration(days: 1));
      final isTrue = (element.isAfter(now)) && (element.isBefore(tmrw));
      return isTrue;
    }).toList();


    final notificationId = reminderId * 1000;


    for(DateTime date in timeRange.take(4)){

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

      notificationId + 1;

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