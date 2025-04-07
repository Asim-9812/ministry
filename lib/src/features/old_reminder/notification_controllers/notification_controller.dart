import 'dart:isolate';
import 'dart:ui';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ministry/src/features/dashboard/presentation/ui/dashboard.dart';
import '../../../app/my_app.dart';
import '../../../core/resources/color_manager.dart';
import '../reminders/general/domain/model/general_model.dart';
import '../reminders/general/widgets/update_general_reminder.dart';
import '../reminders/medicine/presentation/medicine_details.dart';
import '../utils/old_common_utils.dart';
import 'general_notifications.dart';
import 'medicine_notifications.dart';
import 'task_notifications.dart';






class NotificationController {
  static ReceivedAction? initialAction;

  ///  *********************************************
  ///     INITIALIZATIONS
  ///  *********************************************

  static Future<void> initializeLocalNotifications() async {
    await AwesomeNotifications().initialize(
        null, //'resource://drawable/res_app_icon',//
        [
          NotificationChannel(
              channelKey: 'med_alerts',
              channelName: 'Alerts for medicines',
              channelDescription: 'Notifications for medicines',
              playSound: true,
              onlyAlertOnce: false,
              groupAlertBehavior: GroupAlertBehavior.Children,
              importance: NotificationImportance.High,
              criticalAlerts: true,
              enableLights: true,
              enableVibration: true,
              defaultPrivacy: NotificationPrivacy.Private,
              defaultColor: MyColors.primary,
              soundSource: 'resource://raw/res_alarm',
              defaultRingtoneType: DefaultRingtoneType.Ringtone,
              ledColor: MyColors.secondary),
          NotificationChannel(
              channelKey: 'gen_alerts',
              channelName: 'Alerts for generals',
              channelDescription: 'Notifications for generals',
              playSound: true,
              onlyAlertOnce: true,
              groupAlertBehavior: GroupAlertBehavior.Children,
              importance: NotificationImportance.High,
              enableLights: true,
              enableVibration: true,
              defaultRingtoneType: DefaultRingtoneType.Ringtone,
              soundSource: 'resource://raw/res_alarm',
              defaultPrivacy: NotificationPrivacy.Private,
              defaultColor: MyColors.primary,
              ledColor: MyColors.secondary),
          NotificationChannel(
              channelKey: 'tasks_alerts',
              channelName: 'Alerts for doctors tasks',
              channelDescription: 'Notifications for tasks',
              playSound: true,
              onlyAlertOnce: true,
              groupAlertBehavior: GroupAlertBehavior.Children,
              importance: NotificationImportance.High,
              enableLights: true,
              enableVibration: true,
              defaultPrivacy: NotificationPrivacy.Private,
              defaultColor: MyColors.primary,
              ledColor: MyColors.secondary),
          NotificationChannel(
              channelKey: 'misc_alerts',
              channelName: 'Alerts for different tasks',
              channelDescription: 'Notifications for misc',
              playSound: true,
              onlyAlertOnce: true,
              groupAlertBehavior: GroupAlertBehavior.Children,
              importance: NotificationImportance.High,
              enableLights: true,
              enableVibration: true,
              defaultPrivacy: NotificationPrivacy.Private,
              defaultColor: MyColors.primary,
              ledColor: MyColors.secondary),
        ],
        debug: true);

    // Get initial notification action is optional
    initialAction = await AwesomeNotifications()
        .getInitialNotificationAction(removeFromActionEvents: false);
  }

  static ReceivePort? receivePort;
  static Future<void> initializeIsolateReceivePort() async {
    receivePort = ReceivePort('Notification action port in main isolate')
      ..listen(
              (silentData) => onActionReceivedImplementationMethod(silentData));

    // This initialization only happens on main isolate
    IsolateNameServer.registerPortWithName(
        receivePort!.sendPort, 'notification_action_port');
  }

  ///  *********************************************
  ///     NOTIFICATION EVENTS LISTENER
  ///  *********************************************
  ///  Notifications events are only delivered after call this method
  static Future<void> startListeningNotificationEvents() async {
    AwesomeNotifications()
        .setListeners(onActionReceivedMethod: onActionReceivedMethod);
  }

  ///  *********************************************
  ///     NOTIFICATION EVENTS
  ///  *********************************************
  ///
  @pragma('vm:entry-point')
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    if (receivedAction.actionType == ActionType.SilentAction ||
        receivedAction.actionType == ActionType.SilentBackgroundAction) {
      // For background actions, you must hold the execution until the end
      print(
          'Message sent via notification input: "${receivedAction.buttonKeyInput}"');
      // await executeLongTaskInBackground();
    } else {
      // this process is only necessary when you need to redirect the user
      // to a new page or use a valid context, since parallel isolates do not
      // have valid context, so you need redirect the execution to main isolate
      if (receivePort == null) {
        print(
            'onActionReceivedMethod was called inside a parallel dart isolate.');
        SendPort? sendPort =
        IsolateNameServer.lookupPortByName('notification_action_port');

        if (sendPort != null) {
          //print('Redirecting the execution to main isolate process.');
          sendPort.send(receivedAction);
          return;
        }
      }
      return onActionReceivedImplementationMethod(receivedAction);
    }
  }

  static Future<void> onActionReceivedImplementationMethod(
      ReceivedAction receivedAction) async {

    BuildContext context = MyApp.navigatorKey.currentContext!;

    if(receivedAction.payload != null){
      if(receivedAction.payload!['reminderTypeId'] == '1'){

       // print('tapped reminder Id = ${receivedAction.payload!['reminderId']}');
        MyApp.navigatorKey.currentState?.push(routeTo(context, MedicineDetails(medicineId: int.parse(receivedAction.payload!['reminderId']!))));
      }
      else if(receivedAction.payload!['reminderTypeId'] == '2'){
        final reminderBox = Hive.box<GeneralModel>('generals').values.toList();
        final reminder = reminderBox.firstWhere((element) => element.reminderId == int.parse(receivedAction.payload!['reminderId']!));
        MyApp.navigatorKey.currentState?.push(routeTo(context, UpdateGeneralReminder(generalModel: reminder)));
      }
      else if(receivedAction.payload!['reminderTypeId'] == '3'){
        MyApp.navigatorKey.currentState?.pushNamed('/notificationPage');
      }
      else if(receivedAction.payload!['reminderTypeId'] == '4'){
        MyApp.navigatorKey.currentState?.pushNamed('/labReport');
      }
      else if(receivedAction.payload!['reminderTypeId'] == '5'){
        MyApp.navigatorKey.currentState?.pushNamed('/requestFam');
      }
      else if(receivedAction.payload!['reminderTypeId'] == '6'){
        MyApp.navigatorKey.currentState?.pushNamed('/opd');
      }
      else{
        MyApp.navigatorKey.currentState?.push(routeTo(context, Dashboard()));
      }
    }



    // MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
    //     '/notification-page',
    //         (route) =>
    //     (route.settings.name != '/notification-page') || route.isFirst,
    //     arguments: receivedAction);
  }

  ///  *********************************************
  ///     REQUESTING NOTIFICATION PERMISSIONS
  ///  *********************************************
  ///
  static Future<bool> displayNotificationRationale() async {
    bool userAuthorized = false;
    BuildContext context = MyApp.navigatorKey.currentContext!;
    await showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text('Give permission for notifications',
                style: Theme.of(context).textTheme.titleLarge),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Image.asset(
                        'assets/images/animated-bell.gif',
                        height: MediaQuery.of(context).size.height * 0.3,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                    'Allow MOLESS to send notifications'),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text(
                    'Deny',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.red),
                  )),
              TextButton(
                  onPressed: () async {
                    userAuthorized = true;
                    Navigator.of(ctx).pop();
                  },
                  child: Text(
                    'Allow',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.deepPurple),
                  )),
            ],
          );
        });
    return userAuthorized &&
        await AwesomeNotifications().requestPermissionToSendNotifications();
  }

  // ///  *********************************************
  // ///     BACKGROUND TASKS TEST
  // ///  *********************************************
  // static Future<void> executeLongTaskInBackground() async {
  //   print("starting long task");
  //   await Future.delayed(const Duration(seconds: 4));
  //   final url = Uri.parse("http://google.com");
  //   final re = await http.get(url);
  //   print(re.body);
  //   print("long task done");
  // }


  static Future<void> scheduleMedicineNotifications({required Map<String,dynamic> allData}) async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) isAllowed = await displayNotificationRationale();
    if (!isAllowed) return;

    await myMedicineNotifications(allData: allData);
  }


  static Future<void> scheduleGeneralNotifications({required Map<String,dynamic> allData}) async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) isAllowed = await displayNotificationRationale();
    if (!isAllowed) return;

    await myGeneralNotifications(allData: allData);
  }

  static Future<void> scheduleTaskNotifications({required Map<String,dynamic> allData}) async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) isAllowed = await displayNotificationRationale();
    if (!isAllowed) return;

    await myDoctorsTasks(allData: allData);
  }


  static Future<void> resetBadgeCounter() async {
    await AwesomeNotifications().resetGlobalBadge();
  }

  static Future<void> cancelNotifications() async {
    await AwesomeNotifications().cancelAll();
  }
}