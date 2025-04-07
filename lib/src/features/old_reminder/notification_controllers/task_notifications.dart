
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:intl/intl.dart';




Future<void> myDoctorsTasks({
  required Map<String,dynamic> allData
}) async {
  final reminderId = allData['reminderId'];
  final reminderTypeId = allData['reminderTypeId'];
  final title = allData['title'];
  final body = allData['body'];
  final startDate = DateTime.parse(allData['startDate']);
  final patternId = allData['patternId'];

  List<dynamic> specificDays = [];
  int interval = 0;

  final now =DateTime.now();
  final remindDate = DateTime(now.year,now.month,now.day,startDate.hour,startDate.minute);

  final local = await AwesomeNotifications().getLocalTimeZoneIdentifier();


  NotificationContent content = NotificationContent(
      id: reminderId,
      channelKey: 'tasks_alerts',
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
        'reminderTypeId' : reminderTypeId.toString(),
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