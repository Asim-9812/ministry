


import 'package:awesome_notifications/awesome_notifications.dart';




Future<void> myMedicineNotifications({
  required Map<String,dynamic> allData
}) async {

  final reminderId = allData['reminderId'];
  final reminderTypeId = allData['reminderTypeId'];
  final title = allData['title'];
  final body = allData['body'];
  final dateListStrings = allData['dateList'] as List<dynamic>;

  List<DateTime> dateList = dateListStrings.map((e) => DateTime.parse(e)).toList();
  
  List<DateTime> today = dateList.where((element){
    final now = DateTime.now();
    final tmrw = DateTime.now().add(Duration(days: 1));
    final isTrue = (element.isAfter(now)) && (element.isBefore(tmrw));
    return isTrue;
  }).toList();

  // print(today);



  int i = 0;

  for(DateTime date in today.take(4)){
    final initialId = (reminderId*100)+i;
    final contentId = (reminderId*1000)+i;
    final initialTime = date.subtract(Duration(minutes: 10));
    final contentTime = date;

    // print(date);


    NotificationContent content = NotificationContent(
      id: contentId,
      channelKey: 'med_alerts',
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
          'reminderTypeId' : reminderTypeId.toString()
      }
    );

    NotificationSchedule schedule = NotificationCalendar(
      year: contentTime.year,
      month: contentTime.month,
      day: contentTime.day,
      hour: contentTime.hour,
      minute: contentTime.minute,
      // preciseAlarm: true,
      timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier()
    );

    NotificationSchedule initialSchedule = NotificationCalendar(
        year: initialTime.year,
        month: initialTime.month,
        day: initialTime.day,
        hour: initialTime.hour,
        minute: initialTime.minute,
        // preciseAlarm: true,
        timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier()
    );

    NotificationContent initialContent = NotificationContent(
      id: initialId,
      channelKey: 'med_alerts',
      title: title,
      body: '10 minutes before your medicine',
      criticalAlert: true,
      autoDismissible: false,
      wakeUpScreen: true,
      displayOnBackground: true,
      displayOnForeground: true,
      notificationLayout: NotificationLayout.Default,
      payload: {
        'reminderId':reminderId.toString(),
        'reminderTypeId' : reminderTypeId.toString()
      }
    );


    await AwesomeNotifications().createNotification(
      schedule: initialSchedule,
      content: initialContent,
    );

    await AwesomeNotifications().createNotification(
      schedule: schedule,
      content: content,
      actionButtons: [
        NotificationActionButton(key: '1', label: 'Snooze',actionType: ActionType.SilentAction),
        NotificationActionButton(key: '2', label: 'Dismiss',actionType: ActionType.DismissAction)
      ]
    );

    i++;

  }


}